import 'package:flutter/material.dart';

import '../Screens/AddMatchs.dart';
import '../Screens/JoueurList.dart';
import '../Screens/MatchsList.dart';
import '../Screens/AddJoueurs.dart';
import '../Screens/PagePrincipale.dart';

class MyDrawer extends Drawer {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Menu"),
          ),

          ListTile(
            title: const Text('Menu Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PagePrincipale()),
              );
            },
          ),

          ListTile(
            title: const Text("Liste des Joueurs"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JoueurList()),
              );
            },
          ),

          ListTile(
            title: const Text("Liste des Matchs"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MatchsList()),
              );
            },
          ),

          ListTile(
            title: const Text("Ajouter un Joueur"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddJoueurs()),
              );
            },
          ),
          ListTile(
            title: const Text("Ajouter un Match"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddMatchs()),
              );
            },
          ),
        ],
      ),
    );
  }
}
