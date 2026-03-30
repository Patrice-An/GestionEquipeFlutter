import '../../Utils/HTTPContainer.dart';
import 'Requete.dart';

/// Classe de service pour gérer les requêtes liées aux "Rencontres"
class RencontreRequetes {
  // L'URI vers l'endpoint spécifique
  static const String _uri = 'RencontreEndpoint.php';

  /// Récupère le  json rencontre et le stock
  /// @param id (Optionnel) l'identifiant de la ressource

  static Future<HTTPContainer> get() async {
    return await Requete.get(_uri);
  }


  /// Crée une nouvelle rencontre
  /// @param data Les données de la rencontre sous forme de Map (clé: valeur)
  static Future<HTTPContainer> post(Map<String, dynamic> data) async {
    return await Requete.post(_uri, data);
  }

  /// Supprime une rencontre via son ID
  static Future<HTTPContainer> delete(int id) async {
    return await Requete.delete(_uri, id);
  }

  /// Met à jour (remplacement) une rencontre via son ID
  static Future<HTTPContainer> put(int id, Map<String, dynamic> data) async {
    return await Requete.put(_uri, id, data);
  }

  /// Met à jour partiellement une rencontre via son ID
  static Future<HTTPContainer> patch(int id, Map<String, dynamic> data) async {
    return await Requete.patch(_uri, id, data);
  }
}