import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controleur/Providers/RencontreProvider.dart';
import 'RencontreAdd.dart';
import 'RencontreListView.dart';

class RencontreList extends StatelessWidget {
  const RencontreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RencontreAdd())),
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () => context.read<RencontreProvider>().rafraichir(),
            child: const Icon(Icons.replay),
          ),
        ],
      ),
      body: RencontreListView(),
    );
  }
}
