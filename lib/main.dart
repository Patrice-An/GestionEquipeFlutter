import 'package:flutter/material.dart';
import 'Vue/Panels/MyDrawer.dart';
import 'Vue/Screens/PagePrincipale.dart';
import 'Vue/Screens/Rencontre/RencontreProvider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GestEquipe",
      home: PagePrincipale()
    );
  }
}
