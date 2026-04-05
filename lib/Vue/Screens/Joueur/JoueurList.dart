import 'package:GestEquipe/Controleur/RencontreControleur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../MainLayout.dart';
import 'JoueurAdd.dart';
import 'JoueurListView.dart';
import 'JoueurProvider.dart';

class JoueurList extends StatelessWidget {
  const JoueurList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
      JoueurProvider()..rafraichir(),
      builder: (context, child) {
        return Scaffold(
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JoueurAdd())),
                  child: const Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: () => context.read<JoueurProvider>().rafraichir(),
                  child: const Icon(Icons.replay),
                ),
              ],
            ),
          body: JoueurListView()
        );
      }
    );
  }
}
