import 'package:flutter/material.dart';
import 'package:mini_projet_equipen/Screens/AddJoueurs.dart';

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
            drawer:
                 Drawer(
                    child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                            const DrawerHeader(
                              decoration: BoxDecoration(color: Colors.blue),
                              child: Text("Menu"),
                            ),
                            ListTile(
                              title: const Text("Liste des Joueurs"),
                              onTap: null,
                            ),
                            ListTile(
                              title: const Text("Liste des Matchs"),
                              onTap: null,
                            ),
                            ListTile(
                              title: const Text("Ajouter un Joueur"),
                              onTap: null,
                            ),
                            ListTile(
                              title: const Text("Ajouter un Match"),
                              onTap: null,
                            )
                      ],
                    )
                 ),
            body: const Center(
              //TODO Le Body doit pouvoir afficher le prochain match et le dernier match Jouer
              child: Text('Mini-Projet', style: TextStyle(fontSize: 40),),
            )
        ),
        );
    }
}



