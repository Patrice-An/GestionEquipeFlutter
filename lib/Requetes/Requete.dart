import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Utils/HTTPContainer.dart';
import '../Utils/TypeRequete.dart';

class Requete {
  // Remplace par ton URL de serveur réelle
  static const String servUrl = "http://r401-serv.alwaysdata.net";

  // Simulation du stockage JWT (à remplacer par ton gestionnaire d'état ou SecureStorage)
  static String? userJwt;

  /// Méthode privée principale pour centraliser les appels cURL
  static Future<HTTPContainer> _requete(
      TypeRequete type,
      String uri, {
        int? id,
        Map<String, dynamic>? body,
      }) async {
    try {
      // Construction de l'URL avec Query Parameters pour l'ID
      String urlString = "$servUrl$uri";
      if (id != null) {
        urlString += "?id=$id";
      }
      Uri url = Uri.parse(urlString);

      // Préparation des headers (Auth en Base64 comme ton script PHP)
      Map<String, String> headers = {
        'Authorization': base64Encode(utf8.encode(userJwt ?? '')),
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

      // Double décodage fidèle à ton PHP : json_decode($datas['data'])
      dynamic finalData;
      if (rawDatas['data'] != null) {
        finalData = (rawDatas['data'] is String)
            ? jsonDecode(rawDatas['data'])
            : rawDatas['data'];
      }

      return HTTPContainer.getInstance(response.statusCode, finalData);

    } catch (e) {
      print("Erreur réseau: $e");
      return HTTPContainer.getInstance(500);
    }
  }

  // --- Méthodes Publiques ---
  /*
  static Future<HTTPContainer> get(String uri, {int? id}) async {
    return _requete(TypeRequete.GET, uri, id: id);
  }
  */
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