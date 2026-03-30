import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

import 'Files.dart';

//Test de JSON Utils (!!! REMPLACE L'ANCIEN FICHIER JOUEUR)
void main() async {
  // Initialisation du path provider
  WidgetsFlutterBinding.ensureInitialized();

  // Exemple : On simule une sauvegarde (ce qui viendrait de votre serveur)
  String jsonSimule = '[{"nom": "ZI-HAO", "prenom": "Jian"}]';
  await JsonUtils.save(Files.JOUEURS, jsonSimule);

  // Appel de la fonction d'importation sur le fichier stocké
  List<dynamic>? mesJoueurs = await JsonUtils.import(Files.JOUEURS);

  if (mesJoueurs != null) {
    print('Succès ! Nombre de joueurs récupérés : ${mesJoueurs.length}');
    for (var joueur in mesJoueurs) {
      if (joueur is Map<String, dynamic>) {
        print('Joueur : ${joueur['prenom']}, ${joueur['nom']}');
      }
    }
  } else {
    print('Échec de la récupération des données (Fichier introuvable ou erreur).');
  }
}

class JsonUtils {

  /// Importe une liste depuis le stockage local du mobile
  static Future<List<dynamic>?> import(Files fileName) async {
    try {
      // 1. Récupérer le dossier de stockage (Documents)
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/${fileName.path}');

      // 2. Vérifier si le fichier existe avant de lire
      if (await file.exists()) {
        final String content = await file.readAsString();
        final dynamic decoded = jsonDecode(content);

        if (decoded is List) {
          return decoded;
        } else {
          print('Erreur : Le JSON stocké n\'est pas une Liste.');
          return null;
        }
      } else {
        print('Erreur : Le fichier ${fileName.path} n\'existe pas encore dans le stockage.');
        return null;
      }
    } catch (e) {
      print('Erreur lors de l\'import : $e');
      return null;
    }
  }

  /// Sauvegarde une String JSON dans le stockage local du mobile
  static Future<bool> save(Files fileName, String jsonRaw) async {
    try {
      // 1. Trouve le dossier sécurisé sur le téléphone
      final Directory directory = await getApplicationDocumentsDirectory();

      // 2. Crée le chemin complet vers le fichier
      final File file = File('${directory.path}/${fileName.path}');

      // 3. Écrit les données (écrase le fichier s'il existe déjà)
      await file.writeAsString(jsonRaw);

      print("Fichier sauvegardé avec succès dans : ${file.path}");
      return true;
    } catch (e) {
      print("Erreur de stockage mobile : $e");
      return false;
    }
  }
}