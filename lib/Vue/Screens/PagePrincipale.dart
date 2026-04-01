import 'package:flutter/material.dart';
import '../Panels/MyDrawer.dart';
import 'RencontreAdd.dart';
import 'MainLayout.dart';


class PagePrincipale extends StatelessWidget {
  const PagePrincipale({super.key});

  @override
  Widget build(BuildContext context) {
      return MainLayout(
        title: "Accueil",
        child: const Center(
          //TODO Le Body doit pouvoir afficher le prochain match et le dernier match Jouer
          child: Text('Mini-Projet', style: TextStyle(fontSize: 40)),
        ),
      );
  }
}
