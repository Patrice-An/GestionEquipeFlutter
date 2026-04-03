import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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
  final RencontreControleur _c = RencontreControleur.getInstance();

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

  void supprimerJoueur(Joueur joueur) {}

  void afficherEcranModifierRencontre(Joueur joueur) {}

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
          //TODO Rajouter bouton suppr
          //TODO Rajouter bouton modifier
        ],
      ),
    );
  }
}
