import 'package:GestEquipe/Controleur/RencontreControleur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../MainLayout.dart';
import 'JoueurListView.dart';
import 'JoueurProvider.dart';

class JoueurList extends StatelessWidget {
  JoueurList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
      JoueurProvider()..chargerDonnees(),
      builder: (context, child) {
        return MainLayout(
          title: AppLocalizations.of(context)!.listjoueur,
          child: JoueurListView(),
          reloadButton: ElevatedButton(
            onPressed: () => context.read<JoueurProvider>().rafraichir(),
            child: const Icon(Icons.replay)
          ),
        );
      }
    );
  }
}
