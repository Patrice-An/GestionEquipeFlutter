import 'package:GestEquipe/Controleur/RencontreControleur.dart';
import 'package:GestEquipe/Modele/Rencontre/Rencontre.dart';
import 'package:GestEquipe/Modele/Rencontre/RencontreLieu.dart';
import 'package:GestEquipe/Modele/Rencontre/RencontreResultat.dart';
import 'package:GestEquipe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Controleur/Providers/RencontreProvider.dart';

class RencontreAdd extends StatefulWidget {
  final Rencontre? rencontre;

  const RencontreAdd({this.rencontre, super.key});

  @override
  State<StatefulWidget> createState() => StateRencontreAdd(this.rencontre);
}

class StateRencontreAdd extends State<RencontreAdd> {
  Rencontre? _rencontre;
  final RencontreControleur _controleur = RencontreControleur.getInstance();
  DateTime? _dateEtHeure = DateTime.now();
  final TextEditingController _adversaireControleur = TextEditingController();
  final TextEditingController _adresseControleur = TextEditingController();
  RencontreLieu? _lieuSelectionne;
  RencontreResultat? _resultatSelectionne;

  StateRencontreAdd(this._rencontre);

  @override
  void initState() {
    super.initState();
    final bool estAjout = this._rencontre == null;
    if (!estAjout) {
      this._dateEtHeure = this._rencontre!.getDateEtHeure();
      bool estPassee = this._dateEtHeure!.isBefore(DateTime.now());
      if (!estPassee) {
        this._dateEtHeure;
        this._adversaireControleur.text = this._rencontre!.getEquipeAdverse();
        this._adresseControleur.text = this._rencontre!.getAdresse();
        this._lieuSelectionne = this._rencontre!.getLieu();
      } else {
        this._resultatSelectionne = this._rencontre!.getResultat();
      }
    }
  }

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
    context.read<RencontreProvider>().rafraichir();
    if (success) {
      _showSnackBar(localizations.successaddrencontre);
      await context.read<RencontreProvider>().rafraichir();
      Navigator.pop(context);
    } else {
      _showSnackBar(localizations.failaddrencontre);
    }
  }

  Future<void> _modifierRencontre() async {
    if (!mounted) return;
    final localizations = AppLocalizations.of(context)!;

    if (_adversaireControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddrencontreadv);
    if (_adresseControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddrencontreadresse);

    Rencontre modifRencontre = Rencontre(
      0,
      _dateEtHeure!,
      _adversaireControleur.text,
      _adresseControleur.text,
      _lieuSelectionne!,
      null,
    );

    bool success = await _controleur.modifierRencontre(
      this._rencontre!.getRencontreId().toInt(),
      modifRencontre,
    );

    if (success) {
      _showSnackBar(localizations.successaddrencontre);
      Navigator.pop(context, true);
    } else {
      _showSnackBar(localizations.failaddrencontre);
    }
  }

  Future<void> _modifierResultat() async {
    if (!mounted) return;
    final localizations = AppLocalizations.of(context)!;

    if (_resultatSelectionne == null)
      return _showSnackBar(localizations.failresultatrencontre);

    bool success = await _controleur.enregistrerResultat(
      this._rencontre!.getRencontreId().toInt(),
      this._rencontre!,
      _resultatSelectionne!,
    );

    if (success) {
      _showSnackBar(localizations.successmodifrencontre);
      Navigator.pop(context, true);
    } else {
      _showSnackBar(localizations.failmodifrencontre);
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
    final bool estAjout = this._rencontre == null;
    final bool estPassee = !estAjout && _dateEtHeure!.isBefore(DateTime.now());
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                AppBar().preferredSize.height, // Force la hauteur minimale
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 50,
            children: [
              // Ajout d'une rencontre
              if (!estPassee) ...[
                Card(
                  child: Row(
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
                ),

                TextField(
                  controller: _adversaireControleur,
                  keyboardType: TextInputType.name,
                  //Permet de définir le type de clavier à afficher
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.labeladversaire,
                    hintText: AppLocalizations.of(context)!.hintadversaire,
                    border: const OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _adresseControleur,
                  keyboardType: TextInputType.name,
                  //Permet de définir le type de clavier à afficher
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.labeladresse,
                    hintText: AppLocalizations.of(context)!.hintadresse,
                    border: const OutlineInputBorder(),
                  ),
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.labellieu),
                      const SizedBox(width: 10),
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
                ),
                if (estAjout) ...[
                  TextButton(
                    onPressed: _ajouterRencontre,
                    child: Text(AppLocalizations.of(context)!.addrencontre),
                  ),
                ] else ...[
                  TextButton(
                    onPressed: _modifierRencontre,
                    child: Text(
                      AppLocalizations.of(context)!.modifierrencontre,
                    ),
                  ),
                ],
              ] else ...[
                Card(
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.labelresultat),
                      const SizedBox(width: 10),
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
                ),
                TextButton(
                  onPressed: _modifierResultat,
                  child: Text(AppLocalizations.of(context)!.modifierresultat),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
