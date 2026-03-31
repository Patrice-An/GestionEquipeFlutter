import 'package:flutter/material.dart';
import 'Vue/Panels/MyDrawer.dart';
void main() {
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(title: Text("Accueil"),),
            drawer: MyDrawer(),
            body: const Center(
              //TODO Le Body doit pouvoir afficher le prochain match et le dernier match Jouer
              child: Text('Mini-Projet', style: TextStyle(fontSize: 40),),
            )
        ),
        );
    }
}



