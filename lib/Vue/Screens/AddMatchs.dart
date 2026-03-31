import 'package:flutter/material.dart';
import '../Panels/MyDrawer.dart';
import 'MainLayout.dart';

class AddMatchs extends StatelessWidget {
  const AddMatchs({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Ajout d'un Match",
      child: const Center(
        child: Text('AddMatchs', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
