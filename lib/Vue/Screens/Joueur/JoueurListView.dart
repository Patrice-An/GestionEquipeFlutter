import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../Controleur/JoueurControleur.dart';
import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Joueur/Joueur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';
import '../../../l10n/app_localizations.dart';
import 'JoueurProvider.dart';

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
    return Scrollable(
      viewportBuilder: (BuildContext context, ViewportOffset position) {
        return Column(children: generer(provider.getJoueurs()));
      },
    );
  }

  Future<void> _supprimerJoueur(Joueur joueur) async {
    if(!await _c.suppprimerJoueur(joueur.getJoueurId().toInt())){
      _showSnackBar(AppLocalizations.of(context)!.faildeletejoueur)
    };
    context.read<JoueurProvider>().rafraichir();
    _showSnackBar(AppLocalizations.of(context)!.successdeletejoueur);
  }

  void _afficherEcranModifierRencontre(Joueur joueur) {
    // PASSAGE DE PARAMETRE VERS l'ECRAN MODIF
    if(false/*TODO OUVRIR ECRAN MODIF*/){
      _showSnackBar(AppLocalizations.of(context)!.failmodifjoueur);
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(joueur.getNom()),
          Text(joueur.getPrenom()),
          Text(joueur.getNumeroDeLicence()),
          Text(joueur.getStatut().name),
          TextButton(
            style: ButtonStyle(
              backgroundColor: Colors.red,
            ),
              onPressed: (){_supprimerJoueur;},
              child: Text(AppLocalizations.of(context)!.addjoueur)
          ),
          TextButton(
              onPressed: _afficherEcranModifierRencontre,
              child: Text(AppLocalizations.of(context)!.addjoueur)
          )
        ],
      ),
    );
  }
}
