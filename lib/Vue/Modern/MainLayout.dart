import 'package:flutter/material.dart';

import 'Joueur/JoueurList.dart';
import 'PagePrincipale.dart';
import 'Rencontre/RencontreList.dart';
import 'Settings.dart';

class MainLayout extends StatelessWidget {

  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.play_arrow)),
              Tab(icon: Icon(Icons.settings))
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            JoueurList(),
            PagePrincipale(),
            RencontreList(),
            Settings()
          ],
        ),
      ),
    );
  }
}