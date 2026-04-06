import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../MainLayout.dart';
import 'RencontreListView.dart';
import 'package:GestEquipe/Controleur/Providers/RencontreProvider.dart';

class RencontreList extends StatelessWidget {
  const RencontreList({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: AppLocalizations.of(context)!.listrencontre,
      reloadButton: ElevatedButton(
        onPressed: () => context.read<RencontreProvider>().rafraichir(),
        child: const Icon(Icons.replay),
      ),
      child: RencontreListView(),
    );
  }
}
