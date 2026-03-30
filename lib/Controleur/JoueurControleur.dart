import 'package:mini_projet_equipe20/Modele/Requetes/JoueurRequetes.dart';

import '../Modele/Joueur/Joueur.dart';
import '../Utils/Files.dart';
import '../Utils/HTTPContainer.dart';
import '../Utils/JsonUtils.dart';

class JoueurControleur {

  static JoueurControleur? _instance;

  JoueurControleur._internal();

  static JoueurControleur getInstance() {
    _instance ??= JoueurControleur._internal();
    return _instance!;
  }

  Future<void> RafraichirListe() async {
    HTTPContainer listeJoueurs = await JoueurRequetes.get();
    if(listeJoueurs.getCode()==200){
      JsonUtils.save(Files.JOUEURS,listeJoueurs.getData());
    }else{

    }
  }

  List<Joueur> getAllJoueur(){

  }

  Joueur getJoueur(){

  }


}