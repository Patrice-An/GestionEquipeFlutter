import 'package:GestEquipe/Modele/Rencontre/RencontreLieu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Controleur/RencontreControleur.dart';
import '../../../Modele/Rencontre/Rencontre.dart';
import '../../../Modele/Rencontre/RencontreResultat.dart';
import '../../../l10n/app_localizations.dart';
import '../../Panels/MyDrawer.dart';
import '../MainLayout.dart';
import 'RencontreList.dart';

class RencontreAdd extends StatefulWidget {
  final num? id;

  const RencontreAdd({this.id, super.key});

  @override
  State<StatefulWidget> createState() => StateRencontreAdd(id);
}

class StateRencontreAdd extends State<RencontreAdd> {
  num? _id;
  RencontreControleur _controleur = RencontreControleur.getInstance();
  DateTime? _dateEtHeure = DateTime.now();
  TextEditingController _adversaireControleur = TextEditingController();
  TextEditingController _adresseControleur = TextEditingController();
  RencontreLieu? _lieuSelectionne;
  RencontreResultat? _resultatSelectionne;

  StateRencontreAdd(this._id);

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _ajouterRencontre() async {
    if (!mounted) return;
    final localizations = AppLocalizations.of(context)!;

    if (_adversaireControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddrencontreadv);
    if (_adresseControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddrencontreadresse);

    Rencontre nouvelleRencontre = Rencontre(
      0,
      _dateEtHeure!,
      _adversaireControleur.text,
      _adresseControleur.text,
      _lieuSelectionne!,
      null,
    );

    bool success = await _controleur.creerRencontre(nouvelleRencontre);

    if (success) {
      _showSnackBar(localizations.successaddrencontre);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RencontreList()),
      );
    } else {
      _showSnackBar(localizations.failaddrencontre);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateEtHeure ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2999),
    );

    if (pickedDate != null) {
      setState(() {
        _dateEtHeure = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          _dateEtHeure?.hour ?? 12,
          _dateEtHeure?.minute ?? 0,
        );
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateEtHeure ?? DateTime.now()),
    );

    if (pickedTime != null) {
      setState(() {
        // On garde le JOUR actuel mais on change l'HEURE
        final current = _dateEtHeure ?? DateTime.now();
        _dateEtHeure = DateTime(
          current.year,
          current.month,
          current.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool estAjout = this._id == null;
    final bool estPassee = !estAjout && _dateEtHeure!.isBefore(DateTime.now());
    return MainLayout(
      title: AppLocalizations.of(context)!.addrencontre,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Optionnel : ajoute un peu d'air
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Ajout d'une rencontre
            if (estAjout) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.labeldate),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: _selectDate,
                    child: Text(
                      _dateEtHeure != null
                          ? DateFormat('dd/MM/yyyy').format(_dateEtHeure!)
                          : "dd/MM/yyyy",
                    ),
                  ),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: _selectTime,
                    child: Text(
                      _dateEtHeure != null
                          ? DateFormat('hh:mm').format(_dateEtHeure!)
                          : "hh:mm",
                    ),
                  ),
                ],
              ),

              TextField(
                controller: _adversaireControleur,
                keyboardType: TextInputType.name,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Lieu :"),
                  DropdownButton<RencontreLieu>(
                    value: _lieuSelectionne,
                    items: RencontreLieu.values.map((statut) {
                      return DropdownMenuItem(
                        value: statut,
                        child: Text(statut.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _lieuSelectionne = value;
                      });
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: _ajouterRencontre,
                child: Text(AppLocalizations.of(context)!.addrencontre),
              ),
            ] else ...[
              if (!estPassee) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.labeldate),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: _selectDate,
                      child: Text(
                        _dateEtHeure != null
                            ? DateFormat('dd/MM/yyyy').format(_dateEtHeure!)
                            : "dd/MM/yyyy",
                      ),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: _selectTime,
                      child: Text(
                        _dateEtHeure != null
                            ? DateFormat('hh:mm').format(_dateEtHeure!)
                            : "hh:mm",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
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
                const SizedBox(height: 6),
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
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text("Lieu : "),
                    DropdownButton<RencontreLieu>(
                      value: _lieuSelectionne,
                      items: RencontreLieu.values.map((lieu) {
                        return DropdownMenuItem(
                          value: lieu,
                          child: Text(lieu.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _lieuSelectionne = value;
                        });
                      },
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    Text("Lieu : "),
                    DropdownButton<RencontreResultat>(
                      value: _resultatSelectionne,
                      items: RencontreResultat.values.map((resultat) {
                        return DropdownMenuItem(
                          value: resultat,
                          child: Text(resultat.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _resultatSelectionne = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
