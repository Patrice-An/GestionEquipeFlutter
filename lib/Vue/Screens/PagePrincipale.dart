import 'package:flutter/material.dart';
import 'package:mini_projet_equipe20/Vue/Panels/MyDrawer.dart';
import 'AddMatchs.dart';


class PagePrincipale extends StatelessWidget {
  const PagePrincipale({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Accueil")),
        drawer: const MyDrawer(),
        body: const Center(
          //TODO Le Body doit pouvoir afficher le prochain match et le dernier match Jouer
          child: Text('Mini-Projet', style: TextStyle(fontSize: 40)),
        ),
      ),
    );
  }
}
