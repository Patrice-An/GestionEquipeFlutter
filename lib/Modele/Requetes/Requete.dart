import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils/HTTPContainer.dart';
import '../../Utils/Logs.dart';
import '../../Utils/TypeRequete.dart';
import './Authentification.dart';
import 'Configs.dart';

class Requete {

  /// Méthode privée principale pour centraliser les appels cURL
  static Future<HTTPContainer> _requete(
      TypeRequete type,
      String uri, {
        int? id,
        Map<String, dynamic>? body,
      }) async {
    await AuthRequest.askJwt("mr.coach", "mot2passe");
    if(!(await AuthRequest.isJwtValid())){
      Logs.addInfo("Erreur");
      return HTTPContainer.getInstance(401);
    }
    Logs.addInfo("OK");

    try {
      // Construction de l'URL avec Query Parameters pour l'ID
      String urlString = "${Configs.getServUrl()}$uri";
      if (id != null) {
        urlString += "?id=$id";
      }
      Uri url = Uri.parse(urlString);

      // Préparation des headers (Auth en Base64 comme ton script PHP)
      Map<String, String> headers = {
        'Authorization':'Bearer ${Configs.getJwt()}',
        'Content-Type': 'application/json',
      };

      http.Response response;
      String? jsonBody = body != null ? jsonEncode(body) : null;

      // Exécution selon le type (Mapping de l'enum)
      switch (type) {
        case TypeRequete.GET:
          response = await http.get(url, headers: headers);
          break;
        case TypeRequete.POST:
          response = await http.post(url, headers: headers, body: jsonBody);
          break;
        case TypeRequete.DELETE:
          response = await http.delete(url, headers: headers);
          break;
        case TypeRequete.PUT:
          response = await http.put(url, headers: headers, body: jsonBody);
          break;
        case TypeRequete.PATCH:
          response = await http.patch(url, headers: headers, body: jsonBody);
          break;
      }

      // Traitement du retour
      if (response.body.isEmpty) return HTTPContainer.getInstance(500);

      final Map<String, dynamic> rawDatas = jsonDecode(response.body);
      // Vérification du code HTTP (200-299)
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return HTTPContainer.getInstance(response.statusCode);
      }

      // Décodage 2 fois : $datas['data']
      dynamic finalData;
      if (rawDatas['data'] != null) {
        finalData = (rawDatas['data'] is String) ? jsonDecode(rawDatas['data']) : rawDatas['data'];
      }
      if(type == TypeRequete.GET){
        Map<String, dynamic> map = {
          "received": finalData
        };
        return HTTPContainer.getInstance(response.statusCode, map);
      }
      return HTTPContainer.getInstance(response.statusCode, finalData);

    } catch (e) {
      print("Erreur réseau: $e");
      return HTTPContainer.getInstance(500);
    }
  }

  // --- Méthodes Publiques ---
  static Future<HTTPContainer> get(String uri) async {
    return _requete(TypeRequete.GET, uri);
  }

  static Future<HTTPContainer> post(String uri, Map<String, dynamic> body) async {
    return _requete(TypeRequete.POST, uri, body: body);
  }

  static Future<HTTPContainer> delete(String uri, int id) async {
    return _requete(TypeRequete.DELETE, uri, id: id);
  }

  static Future<HTTPContainer> put(String uri, int id, Map<String, dynamic> body) async {
    return _requete(TypeRequete.PUT, uri, id: id, body: body);
  }

  static Future<HTTPContainer> patch(String uri, int id, Map<String, dynamic> body) async {
    return _requete(TypeRequete.PATCH, uri, id: id, body: body);
  }


}