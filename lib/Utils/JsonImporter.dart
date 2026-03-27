import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../Modele/Joueur/Joueur.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String path = 'assets/joueurs.json';

  // On attend maintenant une Liste
  List<dynamic>? mesJoueurs = await JsonImporter.import(path);

  if (mesJoueurs != null) {
    print('Succès ! Nombre de joueurs récupérés : ${mesJoueurs.length}');

    // Exemple : afficher le nom du premier joueur
    if (mesJoueurs.isNotEmpty) {
      for(Map<String,dynamic> joueur in mesJoueurs){
        print('Joueur : ${joueur['prenom']},${joueur['nom']}');
      }
    }
  } else {
    print('Échec de la récupération des données.');
  }
}

class JsonImporter {
  // Le type de retour est maintenant List<dynamic>
  static Future<List<dynamic>?> import(String assetPath) async {
    try {
      final String content = await rootBundle.loadString(assetPath);
      final dynamic decoded = jsonDecode(content);

      // On vérifie si c'est une Liste
      if (decoded is List) {
        return decoded;
      } else {
        print('Erreur : Le JSON n\'est pas une Liste.');
        return null;
      }
    } catch (e) {
      print('Erreur lors de l\'import : $e');
      return null;
    }
  }
}