import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text('Mini-Projet', style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}


