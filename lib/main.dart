import 'package:flutter/material.dart';
import 'Vue/Screens/PagePrincipale.dart';

void main() {
  runApp(const MainApp());
}

/// Application de démonstration de Navigator 1.0 (routes directes).
///
/// Utilise un MaterialApp classique avec home: ScreenHome().
/// Toute la navigation se fait via Navigator.push() et Navigator.pop().
/// Pas de routes nommées, pas de go_router.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Démo Navigator 1.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PagePrincipale(),
    );
  }
}
