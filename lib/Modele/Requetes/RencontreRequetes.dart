import 'package:flutter/material.dart';

import '../../Utils/HTTPContainer.dart';
import '../../Utils/Logs.dart';
import '../../Utils/Type.dart';
import 'Requete.dart';

void main() async {
  // Initialisation du path provider
  WidgetsFlutterBinding.ensureInitialized();
  Logs.init();
  print(await RencontreRequetes.get());
}

/// Classe de service pour gérer les requêtes liées aux "Rencontres"
class RencontreRequetes {
  // L'URI vers l'endpoint spécifique
  static const TypeObjet _type = TypeObjet.RENCONTRES;

  /// Récupère le json rencontre et le stock
  static Future<bool> get() async {
    HTTPContainer recuperation = await Requete.get(_type);
    if(recuperation.getCode()!=200){
      Logs.addInfo(recuperation.getCode().toString());
      return false;
    }
    return true;
  }


  /// Crée une nouvelle rencontre
  /// @param data Les données de la rencontre sous forme de Map (clé: valeur)
  static Future<HTTPContainer> post(Map<String, dynamic> data) async {
    return await Requete.post(_type, data);
  }

  /// Supprime une rencontre via son ID
  static Future<HTTPContainer> delete(int id) async {
    return await Requete.delete(_type, id);
  }

  /// Met à jour (remplacement) une rencontre via son ID
  static Future<HTTPContainer> put(int id, Map<String, dynamic> data) async {
    return await Requete.put(_type, id, data);
  }

  /// Met à jour partiellement une rencontre via son ID
  static Future<HTTPContainer> patch(int id, Map<String, dynamic> data) async {
    return await Requete.patch(_type, id, data);
  }
}