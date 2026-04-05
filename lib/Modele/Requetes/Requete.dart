import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils/HTTPContainer.dart';
import '../../Utils/JsonUtils.dart';
import '../../Utils/Logs.dart';
import '../../Utils/Type.dart';
import '../../Utils/TypeRequete.dart';
import './Authentification.dart';
import 'Configs.dart';

class Requete {

  /// Méthode privée principale pour centraliser les appels cURL
  static Future<HTTPContainer> _requete(
      TypeRequete typeRequete,
      TypeObjet typeObjet, {
        int? id,
        Map<String, dynamic>? body,
      }) async {
    await AuthRequest.askJwt("mr.coach", "mot2passe");
    if(!(await AuthRequest.isJwtValid())){
      Logs.addShout("JWT Invalide!");
      return HTTPContainer.getInstance(401);
    }

    try {
      // Construction de l'URL avec Query Parameters pour l'ID
      String urlString = "${Configs.getServUrl()}${typeObjet.getUri()}";
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
      switch (typeRequete) {
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

      final Map<String, dynamic> result = jsonDecode(response.body);
      // Vérification du code HTTP (200-299)
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return HTTPContainer.getInstance(response.statusCode);
      }

      if(typeRequete == TypeRequete.GET){
        JsonUtils.save(typeObjet.getPath(), result['data']);
        return HTTPContainer.getInstance(response.statusCode);
      }
      return HTTPContainer.getInstance(response.statusCode);

    } catch (e) {
      print("Erreur réseau: $e");
      return HTTPContainer.getInstance(500);
    }
  }

  // --- Méthodes Publiques ---
  static Future<HTTPContainer> get(TypeObjet type) async {
    return _requete(TypeRequete.GET, type);
  }

  static Future<HTTPContainer> post(TypeObjet type, Map<String, dynamic> body) async {
    return _requete(TypeRequete.POST, type, body: body);
  }

  static Future<HTTPContainer> delete(TypeObjet type, int id) async {
    return _requete(TypeRequete.DELETE, type, id: id);
  }

  static Future<HTTPContainer> put(TypeObjet type, int id, Map<String, dynamic> body) async {
    return _requete(TypeRequete.PUT, type, id: id, body: body);
  }

  static Future<HTTPContainer> patch(TypeObjet type, int id, Map<String, dynamic> body) async {
    return _requete(TypeRequete.PATCH, type, id: id, body: body);
  }


}