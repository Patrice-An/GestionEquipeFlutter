import 'package:GestEquipe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../Screens/Joueur/JoueurAdd.dart';
import '../Screens/Joueur/JoueurList.dart';
import '../Screens/Rencontre/RencontreAdd.dart';
import '../Screens/Rencontre/RencontreList.dart';
import '../Screens/PagePrincipale.dart';
import '../Utils/Couleurs.dart';

class MyDrawer extends Drawer {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Couleurs.principale),
            child: const Text("Menu"),
          ),

          ListTile(
            title: Text(AppLocalizations.of(context)!.mainmenu),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PagePrincipale()),
              );
            },
          ),

          ListTile(
            title: Text(AppLocalizations.of(context)!.listjoueur),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoueurList()),
              );
            },
          ),

          ListTile(
            title: Text(AppLocalizations.of(context)!.listrencontre),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RencontreList()),
              );
            },
          ),

          ListTile(
            title: Text(AppLocalizations.of(context)!.addjoueur),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoueurAdd()),
              );
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.addrencontre),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RencontreAdd()),
              );
            },
          ),
        ],
      ),
    );
  }
}
