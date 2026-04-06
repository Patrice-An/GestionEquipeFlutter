import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Utils/HTTPContainer.dart';
import '../../Utils/Logs.dart';
import 'Configs.dart';

class AuthRequest {

  /// Helper pour générer le header Authorization
  static Map<String, String> _getHeaders() {
    String base64Key = base64Encode(utf8.encode(Configs.getAuthKey()));
    return {'Authorization': base64Key, 'Content-Type': 'application/json'};
  }

  /// @param login : le login
  /// @param password : le password
  /// @return Future<HTTPContainer> : instance de HTTPContainer
  static Future<HTTPContainer> askJwt(String login, String password) async {
    try {
      final Map<String, String> logins = {
        'login': login,
        'password': password,
      };
      final body = jsonEncode(logins);
      final response = await http.post(
        Uri.parse(Configs.getAuthUrl()),
        headers: _getHeaders(),
        body: body,
      );
      final dynamic resultat = jsonDecode(response.body);
      if (resultat == null || response.statusCode != 200) {
        return HTTPContainer.getInstance(response.statusCode);
      }
      final decodedData = jsonDecode(resultat['data']);
      Configs.setJwt(decodedData["jwt"]);
      Logs.addInfo("JWT récupéré.");
      return HTTPContainer.getInstance(200);
    } catch (e) {
      return HTTPContainer.getInstance(500);
    }
  }

  /// @param jwt : le client jwt à décoder
  /// @return Future<bool> : le payload décodé (Map) ou false
  static Future<bool> isJwtValid() async {
    try {
      final body = jsonEncode({'jwt': 'Bearer ${Configs.getJwt()}'});

      //Envoie de la requete avec le body
      //Necessite une requete custom car get par defaut ne prends pas de body
      var request = http.Request('GET', Uri.parse(Configs.getAuthUrl()));
      request.headers.addAll(_getHeaders());
      request.body = body;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final datas = jsonDecode(response.body);
      int code = response.statusCode;
      if (code != 200 || datas['data'] == null) {
        return false;
      }
      Logs.addInfo("JWT validé.");
      return true;
    } catch (e) {
      return false;
    }
  }
}

//Test de la fonction d'authentification
void main() async {
  HTTPContainer resultat = await AuthRequest.askJwt("mr.coach", "mot2passe");
  if (resultat.getCode() == 200) {
    bool jwtValid = await AuthRequest.isJwtValid();
  } else {
    print("Erreur gen jwt : ${resultat.getCode()} ${resultat.getMessage()}");
  }
}
