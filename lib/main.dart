import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controleur/Providers/RencontreProvider.dart';
import 'Utils/Logs.dart';
import 'Vue/Modern/MainLayout.dart' as newLayout;
import 'Vue/Modern/PagePrincipale.dart';
import 'Vue/Old/MainLayout.dart' as oldLayout;
import 'l10n/app_localizations.dart';

void main() {
  runApp(Phoenix(child: MainApp()));
}

class MainApp extends StatelessWidget {

  static bool _modernMenu = true;

  const MainApp({super.key});

  Future<Map<String,dynamic>>? _loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> data={
      'styleMenu': prefs.getBool('styleMenu') ?? true
    };
    _modernMenu = data['styleMenu'];
    return data;
  }

  static bool getStyleMenu(){
    return _modernMenu;
  }

  static void changeStyleMenu(bool value){
    _modernMenu = value;
  }

  @override
  Widget build(BuildContext context) {
    Logs.init();
    Logs.addInfo("Nouveau Menu?: $_modernMenu");
    return FutureBuilder(
        future: _loadPreferences(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
          // Attente du chargement des datas users
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          }

          // Echec du chargement
          if (snapshot.hasError || !snapshot.hasData) {
            return const MaterialApp(
              home: Scaffold(body: Center(child: Text("Erreur de chargement"))),
            );
          }

          // Reussite du chargement
          final bool styleModern = snapshot.data!['styleMenu'];
          return ChangeNotifierProvider(
              create: (_) =>
              RencontreProvider()..chargerDonnees(),
              builder: (context, child) {
                if(styleModern) {
                  return MaterialApp(
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: [
                        Locale('en'),
                        Locale('fr')
                      ],
                      title: "GestEquipe", home: newLayout.MainLayout()
                  );
                }else{
                  return MaterialApp(
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: [
                        Locale('en'),
                        Locale('fr')
                      ],
                      title: "GestEquipe", home: oldLayout.MainLayout(
                    title: 'Accueil',
                    child: PagePrincipale(),
                  )
                  );
                }
              }
          );
        }
    );
  }
}
