import 'package:flutter/material.dart';
import 'MainLayout.dart';

class JoueurList extends StatelessWidget {
  const JoueurList({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Liste des Joueurs",
      child: const Center(
        child: Text('Liste Joueurs', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
