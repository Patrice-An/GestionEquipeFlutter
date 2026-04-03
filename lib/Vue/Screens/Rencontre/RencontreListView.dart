import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';
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
      return const Center(child: Text("Aucun rencontres trouvé."));
    }
    print("Fichier rencontres chargés.");
    return Column(
      children: generer(provider.getRencontres())
    );
  }

  void supprimerRencontre(Rencontre rencontre) {}

  void afficherEcranModifierRencontre(Rencontre rencontre) {}

  List<Widget> generer(Set<Rencontre> rencontres) {
    List<Widget> lignes= [];
    for(Rencontre rencontre in rencontres){
      lignes.add(creerLigne(rencontre));
    }
    return lignes;
  }

  Widget creerLigne(Rencontre rencontre){
    return SizedBox(
      width:double.infinity,
      height:24,
        child : Scrollable(
          viewportBuilder: (){
            return Column(
              children: [
                Text(rencontre.getEquipeAdverse()),
                Text(rencontre.getDateEtHeure().toString()),
                Text(rencontre.getLieu().name),
                Text(rencontre.getAdresse())
              ],
            ),}
        )

    );
  }
}
