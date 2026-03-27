import 'dart:convert';
import 'dart:io';
void main() async {
  final String filePath = "../Datas/joueurs.json";

  // Appel de la fonction
  Map<String, dynamic>? maMap = await JsonImporter.import(filePath);

  if (maMap != null) {
    print('Succès ! Valeur de "nom" : ${maMap['nom']}');
  } else {
    print('Échec de la récupération des données.');
  }
}
class JsonImporter {
  static Future<Map<String, dynamic>?> import(String filePath) async {
    final file = File(filePath);

    try {
      // Vérifier si le fichier existe avant de tenter la lecture
      if (!await file.exists()) {
        print('Erreur : Le fichier n\'existe pas.');
        return null;
      }

      // Lire et décoder
      final String content = await file.readAsString();
      final dynamic decoded = jsonDecode(content);

      // Vérifier si le résultat est bien une Map (et non une Liste ou autre)
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        print('Erreur : Le contenu JSON n\'est pas un objet (Map).');
        return null;
      }
    } catch (e) {
      // Capture les erreurs de syntaxe JSON ou de permission de fichier
      print('Erreur lors de la conversion : $e');
      return null;
    }
  }
}
