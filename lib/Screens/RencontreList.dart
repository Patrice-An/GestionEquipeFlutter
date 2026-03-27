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
        Container(
          width: double.infinity,//Permet de prendre toute la largeur de l'écran
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            //Ajouter une ombre pour donner un effet de profondeur
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Résultats IMC',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        )
    );
  }
}
