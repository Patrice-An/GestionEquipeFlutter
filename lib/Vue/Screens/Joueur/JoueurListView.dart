import 'package:flutter/material.dart';

import '../../../Modele/Joueur/Joueur.dart';


class JoueurListView extends StatefulWidget{
  final JoueurControleur _c;
  const JoueurListView(this._c);

  Widget build(BuildContext context, dynamic _items) {
    return FutureBuilder<Set<Joueur>>(
      future: c.,
      builder: (BuildContext context, AsyncSnapshot<Set<Joueur>> snapshot) {  },

    );
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
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void setState(Joueur Function() param0) {}

  }

  void supprimer(Joueur Function() param0){

  }

  void modifier(Joueur Function() param0){

  }
