import 'package:flutter/material.dart';
import 'package:mini_projet_equipe20/Vue/Panels/MyDrawer.dart';



class AddJoueurs extends StatelessWidget {
  const AddJoueurs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: Text("Ajouter un Joueur"),),

        body: const Center(
          child: Text('AddJoueurs', style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}



