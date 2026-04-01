import 'package:flutter/material.dart';

import '../Panels/MyDrawer.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? reloadButton;

  const MainLayout({super.key, required this.title, required this.child, this.reloadButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: reloadButton,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey, // Exemple de style centralisé
      ),
      drawer: const MyDrawer(),
      body: child,
    );
  }
}