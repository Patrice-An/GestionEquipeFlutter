import 'package:GestEquipe/l10n/app_localizations.dart';
import 'package:GestEquipe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {

  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  _SettingsState();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _changerMenu() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('styleMenu', !(MainApp.getStyleMenu()));
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.optionstyle),
                        Switch(
                            value: MainApp.getStyleMenu(),
                            onChanged: (value) {
                              _changerMenu();
                            }
                        )
                      ]
                  ),
                ]
            )
        )
    );
  }
}
