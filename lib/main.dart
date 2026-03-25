import 'package:flutter/material.dart';
import 'Panels/MyAppBar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(name: 'Accueil'),

        body: Center(
          child: Text('Mini-Projet', style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}



