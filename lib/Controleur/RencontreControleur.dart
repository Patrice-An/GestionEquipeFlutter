import 'package:GestEquipe/Modele/Requetes/RencontreRequetes.dart';

import '../Modele/Rencontre/Rencontre.dart';
import '../Modele/Rencontre/RencontreResultat.dart';
import '../Modele/Requetes/RencontreRequetes.dart';
import '../Utils/Type.dart';
import '../Utils/HTTPContainer.dart';
import '../Utils/JsonUtils.dart';

class RencontreControleur {

  static RencontreControleur? _instance;
  static final TypeObjet _type = TypeObjet.RENCONTRES;
  RencontreControleur._internal();

  static RencontreControleur getInstance() {
    _instance ??= RencontreControleur._internal();
    return _instance!;
  }

  static Future<bool> RafraichirListe() async{
    bool reussiteImport = await RencontreRequetes.get();
    return reussiteImport;
  }

  Future<Set<Rencontre>> getAllRencontres() async{
    List<dynamic>? json = await JsonUtils.import(_type.getPath());
    Set<Rencontre> listeRencontre = <Rencontre>{};
    if(json!=null){
      for(Map<String,dynamic> rencontreArray in json){
        listeRencontre.add(Rencontre.fromArray(rencontreArray));
      }
    }
    return listeRencontre;
  }

  Future<Rencontre?> getRencontre(int idRecherche) async {
    // 1. Récupération de la liste
    List<dynamic>? jsonList = await JsonUtils.import(_type.getPath());

    // 2. Vérification si la liste est nulle ou vide
    if (jsonList == null || jsonList.isEmpty) return null;

    try {
      // 3. Recherche de l'élément avec l'ID spécifique
      // On utilise .firstWhere pour s'arrêter dès qu'on trouve le bon
      final rencontreData = jsonList.firstWhere(
            (element) => element['id'] == idRecherche,
        orElse: () => null,
      );

      // 4. Conversion du Map JSON en objet Joueur
      if (rencontreData != null) {
        return Rencontre.fromArray(rencontreData);
      }
    } catch (e) {
      print("Erreur lors de la récupération de la rencontre : $e");
    }
    return null; // Retourne null si rien n'est trouvé
  }

  Future<bool> creerRencontre(Rencontre rencontre) async {
    // 1. Envoie de la requete
    HTTPContainer result = await RencontreRequetes.post(rencontre.toArray());
    if (result.getCode() != 201) {
      return false;
    };
    return true;
  }

  Future<bool> modifierRencontre(int id,Rencontre rencontre) async {
    // 1. Envoie de la requete
    HTTPContainer result = await RencontreRequetes.put(id,rencontre.toArray());
    if (result.getCode() != 204) {
      return false;
    }
    return true;
  }

  Future<bool> enregistrerResultat(int id, Rencontre rencontre,RencontreResultat resultat) async{
    rencontre.setResultat(resultat);
    HTTPContainer result = await RencontreRequetes.patch(id,rencontre.toArray());
    if(result.getCode()!=204){
      return false;
    }
    return true;
  }

  Future<bool> suppprimerRencontre(int id) async {
    // 1. Envoie de la requete
    HTTPContainer result = await RencontreRequetes.delete(id);
    if (result.getCode() != 204) {
      return false;
    }
    return true;
  }

  Future<Set<Rencontre>> getRencontresPassees() async {
    Set<Rencontre> rencontres = await getAllRencontres();

    //Filtrage avant
    List<Rencontre> listeFiltree = rencontres
        .where((rencontre) => rencontre.getDateEtHeure().isBefore(DateTime.now()))
        .toList();

    //Tri par date
    listeFiltree.sort((a, b) => a.getDateEtHeure().compareTo(b.getDateEtHeure()));

    //Reconversion en set
    return listeFiltree.toSet();
  }

  Future<Rencontre?> getDerniereRencontre() async {
    Set<Rencontre> rencontrePasses = await getRencontresPassees();
    if(rencontrePasses.isNotEmpty){
      return rencontrePasses.last;
    }
    return null;
  }

  Future<Set<Rencontre>> getRencontresAVenir() async {
    Set<Rencontre> rencontres = await getAllRencontres();

    //Filtrage apres
    List<Rencontre> listeFiltree = rencontres
        .where((rencontre) => rencontre.getDateEtHeure().isAfter(DateTime.now()))
        .toList();

    //Tri par date
    listeFiltree.sort((a, b) => a.getDateEtHeure().compareTo(b.getDateEtHeure()));

    //Reconversion en set
    return listeFiltree.toSet();
  }

  Future<Rencontre?> getProchaineRencontre() async {
    Set<Rencontre> rencontreAVenir = await getRencontresAVenir();
    if(rencontreAVenir.isNotEmpty){
      return rencontreAVenir.first;
    }
    return null;
  }

}