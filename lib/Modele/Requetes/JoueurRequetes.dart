import '../../Utils/HTTPContainer.dart';
import 'Requete.dart';

/// Classe de service pour gérer les requêtes liées aux "Joueurs"
class JoueurRequetes {
  // L'URI vers l'endpoint spécifique des joueurs
  static const String _uri = 'JoueurEndpoint.php';

  /// Récupère un joueur par son ID ou tous les joueurs si l'ID est nul
  /// Utilisation : JoueurRequetes.get() ou JoueurRequetes.get(id: 42)

  static Future<HTTPContainer> get() async {
    return await Requete.get(_uri);
  }

  /// Crée un nouveau joueur
  /// @param data Map contenant les infos du joueur (ex: {'nom': 'Zidane', 'poste': 'Milieu'})
  static Future<HTTPContainer> post(Map<String, dynamic> data) async {
    return await Requete.post(_uri, data);
  }

  /// Supprime un joueur via son ID
  static Future<HTTPContainer> delete(int id) async {
    return await Requete.delete(_uri, id);
  }

  /// Met à jour (remplacement complet) un joueur via son ID
  static Future<HTTPContainer> put(int id, Map<String, dynamic> data) async {
    return await Requete.put(_uri, id, data);
  }

  /// Met à jour partiellement un joueur via son ID
  static Future<HTTPContainer> patch(int id, Map<String, dynamic> data) async {
    return await Requete.patch(_uri, id, data);
  }
}