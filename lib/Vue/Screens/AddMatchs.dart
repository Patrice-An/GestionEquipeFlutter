import 'package:flutter/material.dart';
import 'package:mini_projet_equipe20/Vue/Panels/MyDrawer.dart';



class AddMatchs extends StatelessWidget {
  const AddMatchs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: Text("Ajouter un Match"),),
        body: const Center(
          child: Text('AddMatchs', style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}



