import 'package:GestEquipe/Controleur/JoueurControleur.dart';
import 'package:GestEquipe/Modele/Joueur/Joueur.dart';
import 'package:flutter/material.dart';


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
      List<Joueur> listeJoueurTries = _joueurs.toList();

      listeJoueurTries.sort((a, b) {
        //Tri nom différent
        int comparaisonNom = a.getNom().compareTo(b.getNom());
        if (comparaisonNom != 0) {
          return comparaisonNom;
        }
        // On compare prénom si nom pareil
        return a.getPrenom().compareTo(b.getPrenom());
      });
      _joueurs = listeJoueurTries.toSet();
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