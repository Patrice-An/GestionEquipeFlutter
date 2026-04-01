import 'package:GestEquipe/Controleur/RencontreControleur.dart';
import 'package:flutter/material.dart';
import '../../Modele/Rencontre/Rencontre.dart';
import '../Panels/MyDrawer.dart';
import 'MainLayout.dart';

class RencontreList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RencontreListState();
}

class _RencontreListState extends State<RencontreList> {
  final RencontreControleur _c = RencontreControleur.getInstance();

  Set<Rencontre> _rencontres;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _chargerDonnees(); // On lance le chargement au démarrage
  }

  // Appelé lors de la création de l'écran
  Future<void> _chargerDonnees() async {
    setState(() => _isLoading = true);
    try {
      final data = await _c.getAllRencontres();
      setState(() {
        _rencontres = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Liste des Matchs",
      reloadButton: ElevatedButton(
        onPressed: reload,
        child: Icon(Icons.replay),
      ),
      child: Container(
        width: double.infinity,
        //Permet de prendre toute la largeur de l'écran
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          //Ajouter une ombre pour donner un effet de profondeur
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Résultats IMC',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void reload() {
    RencontreControleur.RafraichirListe();
    setState(() {});
  }
}
