import 'package:GestEquipe/Modele/Rencontre/RencontreLieu.dart';
import 'package:flutter/material.dart';
import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';
import '../../../l10n/app_localizations.dart';
import '../../Panels/MyDrawer.dart';
import '../MainLayout.dart';

class RencontreAdd extends StatefulWidget {
  final num? id;

  const RencontreAdd({this.id,super.key});

  @override
  State<StatefulWidget> createState() => StateRencontreAdd(id);

}

class StateRencontreAdd extends State<RencontreAdd> {
  num? _id;
  RencontreControleur _controleur = RencontreControleur.getInstance();
  DateTime _dateEtHeure = DateTime.now();
  TextEditingController _adversaireControleur = TextEditingController();
  TextEditingController _adresseControleur = TextEditingController();
  RencontreLieu? _lieuSelectionne;

  StateRencontreAdd(this._id);

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _ajouterRencontre() async {
    if (!mounted) return;
    final localizations = AppLocalizations.of(context)!;

    if (_adversaireControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddrencontreadv);
    if (_adresseControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddrencontreadresse);
    if (DateTime.now().isBefore(_dateEtHeure))
      return _showSnackBar(localizations.failaddrencontredate);

    Rencontre nouvelleRencontre = Rencontre(
        0,
        _dateEtHeure,
        _adversaireControleur.text,
        _adresseControleur.text,
        _lieuSelectionne!,
        null
    );

    bool success = await _controleur.creerRencontre(nouvelleRencontre);

    if (success) {
      _showSnackBar(localizations.successaddjoueur);
      Navigator.pop(context);
    } else {
      _showSnackBar(localizations.failaddjoueur);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool estAjout = this._id == null;
    final bool estPassee = !estAjout && _dateEtHeure.isBefore(DateTime.now());
    return MainLayout(
      title: AppLocalizations.of(context)!.addrencontre,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Ajout d'une rencontre
                if (estAjout) ...[
                  InputDatePickerFormField(
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2999),
                    onDateSubmitted: (date) {
                      setState(() {
                        _dateEtHeure = date;
                      });
                    },
                  ),

                  TextField(
                    controller: _adversaireControleur,
                    keyboardType: TextInputType.number,
                    //Permet de définir le type de clavier à afficher
                    decoration: const InputDecoration(
                      labelText: 'Equipe adverse',
                      hintText: 'Jean Jaures',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _adresseControleur,
                    keyboardType: TextInputType.name,
                    //Permet de définir le type de clavier à afficher
                    decoration: const InputDecoration(
                      labelText: 'Adresse',
                      hintText: '8 Rue de Jean Jaures',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  DropdownButton<RencontreLieu>(
                    value: _lieuSelectionne,
                    items: RencontreLieu.values.map((statut) {
                      return DropdownMenuItem(
                        value: statut,
                        child: Text(statut.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _lieuSelectionne = value;
                      });
                    },
                  ),
                  TextButton(
                      onPressed: _ajouterRencontre,
                      child: Text(AppLocalizations.of(context)!.addrencontre)
                  )
                ] else
                  ...[
                    if (!estPassee) ...[
                      InputDatePickerFormField(
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2999),
                        onDateSubmitted: (date) {
                          setState(() {
                            _dateEtHeure = date;
                          });
                        },
                      ),

                      TextField(
                        controller: _adversaireControleur,
                        keyboardType: TextInputType.number,
                        //Permet de définir le type de clavier à afficher
                        decoration: const InputDecoration(
                          labelText: 'Equipe adverse',
                          hintText: 'Jean Jaures',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: _adresseControleur,
                        keyboardType: TextInputType.name,
                        //Permet de définir le type de clavier à afficher
                        decoration: const InputDecoration(
                          labelText: 'Adresse',
                          hintText: '8 Rue de Jean Jaures',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      DropdownButton<RencontreLieu>(
                        value: _lieuSelectionne,
                        items: RencontreLieu.values.map((statut) {
                          return DropdownMenuItem(
                            value: statut,
                            child: Text(statut.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _lieuSelectionne = value;
                          });
                        },
                      ),
                    ] else
                      ...[
                        DropdownButton<RencontreLieu>(
                          value: _lieuSelectionne,
                          items: RencontreLieu.values.map((statut) {
                            return DropdownMenuItem(
                              value: statut,
                              child: Text(statut.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _lieuSelectionne = value;
                            });
                          },
                        )
                      ]
                  ]
              ]
          )
      ),
    );
  }
}

