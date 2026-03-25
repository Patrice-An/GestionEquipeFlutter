import 'package:flutter/material.dart';

class AfficherMatchs extends StatelessWidget {


  const AfficherMatchs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listes des Matchs'),
        ),
        body:
        Text("Emplacements listView")
    );
  }
}
