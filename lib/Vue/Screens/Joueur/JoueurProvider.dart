import 'package:flutter/material.dart';

import '../../../Controleur/JoueurControleur.dart';
import '../../../Modele/Joueur/Joueur.dart';


class JoueurProvider extends ChangeNotifier {
  final JoueurControleur _c = JoueurControleur.getInstance();

  Set<Joueur> _joueurs = {};
  bool _isLoading = false;

  Set<Joueur> getJoueurs(){
    return _joueurs;
  }

  bool isLoading(){
    return _isLoading;
  }

  Future<void> chargerDonnees() async {
    _isLoading = true;
    notifyListeners();
    try {
      _joueurs = await _c.getAllJoueurs();
      print(_joueurs.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> rafraichir() async {
    await JoueurControleur.RafraichirListe();
    await chargerDonnees();
  }
}