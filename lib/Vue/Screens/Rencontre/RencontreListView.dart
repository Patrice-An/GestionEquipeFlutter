import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';
import '../../../l10n/app_localizations.dart';
import 'RencontreProvider.dart';

class RencontreListView extends StatefulWidget {
  const RencontreListView({super.key});

  @override
  State<StatefulWidget> createState() => RencontreListViewState();
}

class RencontreListViewState extends State<RencontreListView> {
  final RencontreControleur _c = RencontreControleur.getInstance();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RencontreProvider>();
    if (provider.isLoading()) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.getRencontres().isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.norencontrefound));
    } else {
        return ListView(children: generer(provider.getRencontres()));
    }
  }

  void supprimerRencontre(Rencontre rencontre) {}

  void afficherEcranModifierRencontre(Rencontre rencontre) {}

  List<Widget> generer(Set<Rencontre> rencontres) {
    List<Widget> lignes = [];
    for (Rencontre rencontre in rencontres) {
      lignes.add(creerLigne(rencontre));
    }
    return lignes;
  }

  Widget creerLigne(Rencontre rencontre) {
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
              rencontre.getEquipeAdverse(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(rencontre.getDateEtHeure().toString()),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.location_city, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(rencontre.getLieu().name),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.place, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(rencontre.getAdresse()),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    afficherEcranModifierRencontre(rencontre);
                  },
                  child: const Text("Modifier"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    supprimerRencontre(rencontre);
                  },
                  child: const Text("Supprimer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
