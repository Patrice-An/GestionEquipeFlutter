import 'package:flutter/material.dart';

import '../Screens/Rencontre/RencontreAdd.dart';
import '../Screens/JoueurList.dart';
import '../Screens/Rencontre/RencontreList.dart';
import '../Screens/JoueursAdd.dart';
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
                MaterialPageRoute(builder: (context) => RencontreList()),
              );
            },
          ),

          ListTile(
            title: const Text("Ajouter un Joueur"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JoueurAdd()),
              );
            },
          ),
          ListTile(
            title: const Text("Ajouter un Match"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RencontreAdd()),
              );
            },
          ),
        ],
      ),
    );
  }
}
