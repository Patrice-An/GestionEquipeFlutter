import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Utils/HTTPContainer.dart';
import '../../Utils/JsonUtils.dart';
import '../../Utils/Logs.dart';
import '../../Utils/Paths.dart';
import 'RencontreRequetes.dart';
import 'Requete.dart';

void main() async {
  // Initialisation du path provider
  WidgetsFlutterBinding.ensureInitialized();
  Logs.init();
  print(await JoueurRequetes.get());
}

/// Classe de service pour gérer les requêtes liées aux "Joueurs"
class JoueurRequetes {
  // L'URI vers l'endpoint spécifique des joueurs
  static const String _uri = 'JoueurEndpoint.php';

  /// Récupère un joueur par son ID ou tous les joueurs si l'ID est nul
  /// Utilisation : JoueurRequetes.get() ou JoueurRequetes.get(id: 42)

  static Future<bool> get() async {
    HTTPContainer recuperation = await Requete.get(_uri);
    if(recuperation.getCode()!=200){
      Logs.addInfo(recuperation.getCode().toString());
      return false;
    }
    Map<String,dynamic> data  = recuperation.getData();
    List<dynamic> liste = data["received"];
    String json = jsonEncode(liste);
    JsonUtils.save(Paths.JOUEURS, json);
    return true;
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