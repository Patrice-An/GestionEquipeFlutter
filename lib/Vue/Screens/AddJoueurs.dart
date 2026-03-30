import 'package:flutter/material.dart';



class AddJoueurs extends StatelessWidget {
  const AddJoueurs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Ajouter un Joueur"),),

        body: const Center(
          child: Text('Mini-Projet', style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}



