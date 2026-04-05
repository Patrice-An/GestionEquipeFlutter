import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'Utils/Logs.dart';
import 'Vue/Screens/MainLayout.dart';
import 'Vue/Screens/PagePrincipale.dart';
import 'Vue/Screens/Rencontre/RencontreProvider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logs.init();
    return ChangeNotifierProvider(
        create: (_) =>
        RencontreProvider()..chargerDonnees(),
        builder: (context, child) {
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
              title: "GestEquipe", home: MainLayout()
          );
        }
    );
  }
}
