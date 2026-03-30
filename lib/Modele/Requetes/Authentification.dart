import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils/HTTPContainer.dart';

// Simulation de tes variables globales PHP
class Config {
  static const String authUrl = "http://r401-auth.alwaysdata.net/clientapi.php";
  static const String authKey =
      "AZeXA/pVPzt#6+U2FZXdtg#c!/S*+w7fAgbT2uBUU-pk6qfmdkJS7F#KVW?N!45z";
}

class AuthRequest {
  /// Helper pour générer le header Authorization
  static Map<String, String> _getHeaders() {
    String base64Key = base64Encode(utf8.encode(Config.authKey));
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
        Uri.parse(Config.authUrl),
        headers: _getHeaders(),
        body: body,
      );
      final dynamic resultat = jsonDecode(response.body);
      print(resultat.toString());
      if (resultat == null || response.statusCode != 200) {
        return HTTPContainer.getInstance(response.statusCode);
      }
      final decodedData = jsonDecode(resultat['data']);
      return HTTPContainer.getInstance(200, decodedData);
    } catch (e) {
      return HTTPContainer.getInstance(500);
    }
  }

  /// @param jwt : le client jwt à décoder
  /// @return Future<bool> : le payload décodé (Map) ou false
  static Future<bool> isJwtValid(String jwt) async {
    try {
      final body = jsonEncode({'jwt': 'Bearer $jwt'});

      //Envoie de la requete avec le body
      //Necessite une requete custom car get par defaut ne prends pas de body
      var request = http.Request('GET', Uri.parse(Config.authUrl));
      request.headers.addAll(_getHeaders());
      request.body = body;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final datas = jsonDecode(response.body);
      int code = response.statusCode;
      if (code != 200 || datas['data'] == null) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

//Test de la fonction d'authentification
void main() async {
  HTTPContainer resultat = await AuthRequest.askJwt("xxx", "xxx");
  if (resultat.getCode() == 200) {
    Map<String,dynamic> jwt = resultat.getData();
    print("JWT : ${jwt["jwt"]}");
    bool jwtValid = await AuthRequest.isJwtValid(jwt["jwt"]);
    print("jwt valid : ${jwtValid.toString()}");
  } else {
    print("Erreur gen jwt : ${resultat.getCode()} ${resultat.getMessage()}");
  }
}
