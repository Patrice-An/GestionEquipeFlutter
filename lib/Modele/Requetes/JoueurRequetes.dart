import 'package:flutter/material.dart';

import '../../Utils/HTTPContainer.dart';
import '../../Utils/Logs.dart';
import '../../Utils/Type.dart';
import 'Requete.dart';

void main() async {
  // Initialisation du path provider
  WidgetsFlutterBinding.ensureInitialized();
  Logs.init();
  print(await JoueurRequetes.get());
}

/// Classe de service pour gérer les requêtes liées aux "Joueurs"
class JoueurRequetes {
  // L'URI vers l'endpoint des joueurs
  static final TypeObjet _type = TypeObjet.JOUEURS;

  /// Récupère un joueur par son ID ou tous les joueurs si l'ID est nul
  /// Utilisation : JoueurRequetes.get() ou JoueurRequetes.get(id: 42)

  static Future<bool> get() async {
    HTTPContainer recuperation = await Requete.get(_type);
    if(recuperation.getCode()!=200){
      Logs.addShout("Echec import ${recuperation.getCode().toString()}");
      return false;
    }
    Logs.addInfo("Reussite Import");
    return true;
  }

  /// Crée un nouveau joueur
  /// @param data Map contenant les infos du joueur (ex: {'nom': 'Zidane', 'poste': 'Milieu'})
  static Future<HTTPContainer> post(Map<String, dynamic> data) async {
    return await Requete.post(_type, data);
  }

  /// Supprime un joueur via son ID
  static Future<HTTPContainer> delete(int id) async {
    return await Requete.delete(_type, id);
  }

  /// Met à jour (remplacement complet) un joueur via son ID
  static Future<HTTPContainer> put(int id, Map<String, dynamic> data) async {
    return await Requete.put(_type, id, data);
  }

  /// Met à jour partiellement un joueur via son ID
  static Future<HTTPContainer> patch(int id, Map<String, dynamic> data) async {
    return await Requete.patch(_type, id, data);
  }
}