import 'package:flutter/material.dart';

import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';


class RencontreListView extends StatefulWidget{
  final RencontreControleur _c;
  const RencontreListView(this._c);

  Widget build(BuildContext context, dynamic _items) {
    return FutureBuilder<Set<Rencontre>>(
      future: this._c.getAllRencontres(),
      builder: (BuildContext context, AsyncSnapshot<Set<Rencontre>> snapshot) {
        ListView.builder(
          // ListView.builder pour afficher une liste dynamique
          itemCount: _items.length,
          itemBuilder:
              (context, index) =>
              ListTile(
                // ListTile est un gabarit généralement utilisé pour afficher un item de ListView
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                title: Text(
                  "coucou",
                  style: const TextStyle(fontSize: 30),
                ),

                // Affichage d'un SnackBar lors du tap sur un item.
                // Le SnackBar est un widget qui affiche un message temporaire en bas de l'écran
                onTap:
                    () =>
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Item sélectionné: ',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    ),
              ),
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void setState(Joueur Function() param0) {

  }

  void supprimer(Joueur Function() param0){

  }

  void modifier(Joueur Function() param0){

  }
