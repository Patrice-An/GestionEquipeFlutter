import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Utils/HTTPContainer.dart';


// Simulation de tes variables globales PHP
class Config {
  static const String authUrl = "https://ton-api.com/auth";
  static const String authKey = "TA_CLE_AUTH";
}

class AuthRequest {

  /// Helper pour générer le header Authorization
  Map<String, String> _getHeaders() {
    String base64Key = base64Encode(utf8.encode(Config.authKey));
    return {
      'Authorization': base64Key,
      'Content-Type': 'application/json',
    };
  }

  /// @param login : le login
  /// @param password : le password
  /// @return Future<dynamic> : code erreur (int) ou instance de HTTPContainer
  Future<dynamic> askJwt(String login, String password) async {
    try {
      final body = jsonEncode({
        'login': login,
        'password': password,
      });

      final response = await http.post(
        Uri.parse(Config.authUrl),
        headers: _getHeaders(),
        body: body,
      );

      final datas = jsonDecode(response.body);

      if (datas == null) return 500;

      if (response.statusCode != 200) {
        return response.statusCode;
      }

      // Reproduction du double décodage JSON de ton PHP
      final decodedData = jsonDecode(datas['data']);
      return HTTPContainer.getInstance(200, decodedData);

    } catch (e) {
      return 500;
    }
  }

  /// @param jwt : le client jwt à décoder
  /// @return Future<dynamic> : le payload décodé (Map) ou false
  Future<dynamic> getJwtData(String jwt) async {
    try {
      final body = jsonEncode({
        'jwt': 'Bearer $jwt',
      });

      // En PHP tu utilises un GET avec un Body.
      // En Dart (http standard), on utilise Request pour permettre cela :
      var request = http.Request('GET', Uri.parse(Config.authUrl));
      request.headers.addAll(_getHeaders());
      request.body = body;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final datas = jsonDecode(response.body);

      if (response.statusCode != 200 || datas['data'] == null) {
        return false;
      }

      return jsonDecode(datas['data']);

    } catch (e) {
      return false;
    }
  }
}