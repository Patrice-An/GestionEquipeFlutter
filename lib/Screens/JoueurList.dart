import 'package:flutter/material.dart';

class JoueurList extends StatelessWidget {


  const JoueurList({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Historique'),
        ),
        body:
        Text("List View Joueurs")
    );
  }
}

