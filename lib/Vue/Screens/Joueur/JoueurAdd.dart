import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../MainLayout.dart';
import '../../Panels/MyDrawer.dart';
import '../MainLayout.dart';

class JoueurAdd extends StatelessWidget {
  const JoueurAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Ajout d'un Joueur",
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              keyboardType: TextInputType.number,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: "N° Licence",
                hintText: '1059969',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'Nom',
                hintText: 'Ex: LABRIQUE',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'Prénom',
                hintText: 'Ex: Bob',
                border: OutlineInputBorder(),
              ),
            ),
            InputDatePickerFormField(
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              fieldLabelText: 'Date de naissance',
            ),
            TextField(
              keyboardType: TextInputType.number,//Permet de définir le type de clavier à afficher
              decoration: const InputDecoration(
                labelText: 'Poids (kg)',
                hintText: 'Entre 30 et 300 kg',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Taille (cm)',
                hintText: 'Entre 50 et 250 cm',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(onPressed: (){}, child: Text("Ajouter le joueur"),)
          ]
        ),
      ),

    );
  }
}
