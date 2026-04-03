import 'package:GestEquipe/Controleur/RencontreControleur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../MainLayout.dart';
import 'RencontreListView.dart';
import 'RencontreProvider.dart';

class RencontreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
      RencontreProvider()..chargerDonnees(),
      builder: (context, child) {
        return MainLayout(
          title: "Liste des Rencontres",
          child: RencontreListView(),
          reloadButton: ElevatedButton(
            onPressed: () => context.read<RencontreProvider>().rafraichir(),
            child: const Icon(Icons.replay)
          ),
        );
      }
    );
  }
}
