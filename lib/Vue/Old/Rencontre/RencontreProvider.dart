import 'package:flutter/material.dart';

import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';

class RencontreProvider extends ChangeNotifier {
  final RencontreControleur _c = RencontreControleur.getInstance();

  Set<Rencontre> _rencontres = {};
  bool _isLoading = false;

  Set<Rencontre> getRencontres(){
    return _rencontres;
  }

  bool isLoading(){
    return _isLoading;
  }

  Future<void> chargerDonnees() async {
    _isLoading = true;
    notifyListeners();
    try {
      _rencontres = await _c.getAllRencontres();
      List<Rencontre> listeRencontres = _rencontres.toList();

      listeRencontres.sort((a, b) {
        return b.getDateEtHeure().compareTo(a.getDateEtHeure());
      });
      _rencontres = listeRencontres.toSet();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> rafraichir() async {
    await RencontreControleur.RafraichirListe();
    await chargerDonnees();
  }
}