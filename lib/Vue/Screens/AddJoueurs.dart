import 'package:flutter/material.dart';
import '../Panels/MyDrawer.dart';
import 'MainLayout.dart';

class AddJoueurs extends StatelessWidget {
  const AddJoueurs({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Ajout d'un Joueur",
      child: const Center(
          child: Text('AddJoueurs', style: TextStyle(fontSize: 40)),
        ),
    );
  }
}
