import 'package:GestEquipe/Modele/Rencontre/RencontreResultat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';
import '../../../l10n/app_localizations.dart';
import 'RencontreAdd.dart';
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _supprimerRencontre(Rencontre rencontre) async{
    if(!await _c.suppprimerRencontre(rencontre.getRencontreId().toInt())){
      _showSnackBar(AppLocalizations.of(context)!.faildeleterencontre);
      return;
    };
    await context.read<RencontreProvider>().rafraichir();
    _showSnackBar(AppLocalizations.of(context)!.successdeleterencontre);
  }

  void _afficherEcranModifierRencontre(Rencontre rencontre) async{
    // PASSAGE DE PARAMETRE VERS l'ECRAN MODIF
    if(!(await Navigator.push(context, MaterialPageRoute(builder: (context) => RencontreAdd(rencontre : rencontre))))){
      _showSnackBar(AppLocalizations.of(context)!.failmodifrencontre);
    return;
    };
    await context.read<RencontreProvider>().rafraichir();
    _showSnackBar(AppLocalizations.of(context)!.successmodifrencontre);
  }

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
                  Text(AppLocalizations.of(context)!.labelresultat),
                  switch(rencontre.getResultat()) {
                    RencontreResultat.VICTOIRE => Icon(Icons.check_box, color: Colors.green),
                    RencontreResultat.PERDU => Icon(Icons.close, color: Colors.red),
                    RencontreResultat.NUL => Icon(Icons.indeterminate_check_box, color: Colors.grey),
                    _ => Icon(Icons.question_mark_outlined, color: Colors.yellow),
                  },
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _afficherEcranModifierRencontre(rencontre);
                  },
                  child: Text(AppLocalizations.of(context)!.modifierrencontre),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      _supprimerRencontre(rencontre);
                    },
                    child: Text(
                        AppLocalizations.of(context)!.deleterencontre,
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
