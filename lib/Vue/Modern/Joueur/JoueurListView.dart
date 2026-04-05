import 'package:GestEquipe/Controleur/JoueurControleur.dart';
import 'package:GestEquipe/Modele/Joueur/Joueur.dart';
import 'package:GestEquipe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controleur/Providers/JoueurProvider.dart';
import 'JoueurAdd.dart';

class JoueurListView extends StatefulWidget {
  const JoueurListView({super.key});

  @override
  State<StatefulWidget> createState() => JoueurListViewState();
}

class JoueurListViewState extends State<JoueurListView> {
  final JoueurControleur _c = JoueurControleur.getInstance();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JoueurProvider>();
    if (provider.isLoading()) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.getJoueurs().isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.nojoueurfound));
    }
    return ListView(children: generer(provider.getJoueurs()));
  }

  Future<void> _supprimerJoueur(Joueur joueur) async {
    if(!await _c.suppprimerJoueur(joueur.getJoueurId().toInt())){
      _showSnackBar(AppLocalizations.of(context)!.faildeletejoueur);
      return;
    };
    context.read<JoueurProvider>().rafraichir();
    _showSnackBar(AppLocalizations.of(context)!.successdeletejoueur);
  }

  void _afficherEcranModifierRencontre(Joueur joueur) async{
    // PASSAGE DE PARAMETRE VERS l'ECRAN MODIF
    if(!(await Navigator.push(context, MaterialPageRoute(builder: (context) => JoueurAdd(joueur : joueur))))){
      _showSnackBar(AppLocalizations.of(context)!.failmodifjoueur);
      return;
    };
    context.read<JoueurProvider>().rafraichir();
    _showSnackBar(AppLocalizations.of(context)!.successmodifjoueur);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  List<Widget> generer(Set<Joueur> joueurs) {
    List<Widget> lignes = [];
    for (Joueur joueur in joueurs) {
      lignes.add(creerLigne(joueur));
    }
    return lignes;
  }

  Widget creerLigne(Joueur joueur) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "${joueur.getNom()} ${joueur.getPrenom()}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.badge, size: 16),
                const SizedBox(width: 8),
                Text(joueur.getNumeroDeLicence()),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 8),
                Text(joueur.getStatut().name),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _afficherEcranModifierRencontre(joueur);
                  },
                  child: Text(AppLocalizations.of(context)!.modifiedplayer),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    _supprimerJoueur(joueur);
                  },
                  child: Text(
                      AppLocalizations.of(context)!.deleteplayer,
                  style: const TextStyle(color: Colors.black)
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
