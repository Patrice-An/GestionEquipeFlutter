import 'package:flutter/material.dart';
import '../../Panels/MyDrawer.dart';
import '../MainLayout.dart';

class RencontreAdd extends StatelessWidget {
  const RencontreAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Ajouter une Match',
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              keyboardType: TextInputType.datetime,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'date_heure',
                hintText: '01/04/2026',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'Equipe adverse',
                hintText: 'Jean Jaures',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'Adresse',
                hintText: '8 Rue de Jean Jaures',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'Lieu',
                hintText: 'Ex: Mirail',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'Resultats',
                hintText: '9-0',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(onPressed: (){}, child: Text("Ajouter le Match"),)
          ]
        ),
      ),
    );
  }
}
