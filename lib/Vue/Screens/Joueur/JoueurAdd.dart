import 'package:GestEquipe/Controleur/JoueurControleur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../../Modele/Joueur/Joueur.dart';
import '../../../Modele/Joueur/JoueurStatut.dart';
import '../../../l10n/app_localizations.dart';
import '../MainLayout.dart';
import 'package:intl/intl.dart';

import 'JoueurList.dart';

class JoueurAdd extends StatefulWidget {
  final Joueur? joueur;

  const JoueurAdd({this.joueur, super.key});

  @override
  State<JoueurAdd> createState() => _JoueurAddState(this.joueur);
}

class _JoueurAddState extends State<JoueurAdd> {
  final Joueur? _joueur;
  final JoueurControleur _controleur = JoueurControleur.getInstance();

  final TextEditingController _licenceControleur = TextEditingController();
  final TextEditingController _nomControleur = TextEditingController();
  final TextEditingController _prenomControleur = TextEditingController();
  final TextEditingController _tailleControleur = TextEditingController();
  final TextEditingController _poidsControleur = TextEditingController();

  JoueurStatut? _statutSelectionne;
  DateTime? _dateNaissance;

  _JoueurAddState(this._joueur);

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    setState(() {
      _dateNaissance = pickedDate;
    });
  }

  @override
  void dispose() {
    _licenceControleur.dispose();
    _nomControleur.dispose();
    _prenomControleur.dispose();
    _tailleControleur.dispose();
    _poidsControleur.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _ajouterJoueur() async {
    final localizations = AppLocalizations.of(context)!;

    if (_licenceControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurlicence);
    if (_nomControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurnom);
    if (_prenomControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurprenom);
    if (_poidsControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurpoids);
    if (_tailleControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurtaille);
    if (_dateNaissance == null)
      return _showSnackBar(localizations.failaddjoueurdate);
    if (_statutSelectionne == null)
      return _showSnackBar(localizations.failaddjoueurstatut);

    Joueur nouveauJoueur = Joueur(
      0,
      _nomControleur.text,
      _prenomControleur.text,
      _licenceControleur.text,
      _dateNaissance!,
      num.parse(_tailleControleur.text),
      num.parse(_poidsControleur.text),
      _statutSelectionne!,
    );

    bool success = await _controleur.creerJoueur(nouveauJoueur);

    if (!mounted) return;

    if (success) {
      _showSnackBar(localizations.successaddjoueur);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JoueurList()));
    } else {
      _showSnackBar(localizations.failaddjoueur);
    }
  }

  Future<void> _modifierJoueur() async {
    final localizations = AppLocalizations.of(context)!;

    if (_licenceControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurlicence);
    if (_nomControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurnom);
    if (_prenomControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurprenom);
    if (_poidsControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurpoids);
    if (_tailleControleur.text.isEmpty)
      return _showSnackBar(localizations.failaddjoueurtaille);
    if (_dateNaissance == null)
      return _showSnackBar(localizations.failaddjoueurdate);
    if (_statutSelectionne == null)
      return _showSnackBar(localizations.failaddjoueurstatut);

    Joueur modifJoueur = Joueur(
      0,
      _nomControleur.text,
      _prenomControleur.text,
      _licenceControleur.text,
      _dateNaissance!,
      num.parse(_tailleControleur.text),
      num.parse(_poidsControleur.text),
      _statutSelectionne!,
    );
    bool success = await _controleur.modifierJoueur(_joueur!.getJoueurId().toInt(),modifJoueur);
    if (!mounted) return;

    if (success) {
      _showSnackBar(localizations.successmodifjoueur);
      Navigator.pop(context, true);
    } else {
      _showSnackBar(localizations.failmodifjoueur);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool estAjout = this._joueur == null;
    if(!estAjout){
      this._dateNaissance = this._joueur.getDateDeNaissance();
      this._statutSelectionne = this._joueur.getStatut();
      this._licenceControleur.text = this._joueur.getNumeroDeLicence();
      this._nomControleur.text = this._joueur.getNom();
      this._prenomControleur.text = this._joueur.getPrenom();
      this._tailleControleur.text = this._joueur.getTailleEnCm().toString();
      this._poidsControleur.text = this._joueur.getPoidsEnKg().toString();
    }
    return MainLayout(
      title: AppLocalizations.of(context)!.addjoueur,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Optionnel : ajoute un peu d'air
        child: Column(
          children: [
            if (estAjout) ...[
              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _licenceControleur,
                keyboardType: TextInputType.number,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labellicence,
                  //"N° Licence",
                  hintText: AppLocalizations.of(context)!.hintlicence,
                  //'1059969',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-ZàâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ ]'),
                  ),
                ],
                controller: _nomControleur,
                keyboardType: TextInputType.name,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labelnom,
                  //'Nom',
                  hintText: AppLocalizations.of(context)!.labelnom,
                  //'Ex: LABRIQUE',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-ZàâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ ]'),
                  ),
                ],
                controller: _prenomControleur,
                keyboardType: TextInputType.name,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labelprenom,
                  //'Prénom',
                  hintText: AppLocalizations.of(context)!.hintprenom,
                  //'Ex: Bob',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _poidsControleur,
                keyboardType: TextInputType.number,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labelpoids,
                  //'Poids (kg)',
                  hintText: AppLocalizations.of(context)!.hintpoids,
                  //'Entre 30 et 300 kg',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _tailleControleur,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labeltaille,
                  //'Taille (cm)'
                  hintText: AppLocalizations.of(context)!.hinttaille,
                  //'Entre 50 et 250 cm',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.labeldate),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: _selectDate,
                    child: Text(
                      _dateNaissance != null
                          ? DateFormat('dd/MM/yyyy').format(_dateNaissance!)
                          : "dd/MM/yyyy",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.labelstatut),
                  const SizedBox(width: 5),
                  DropdownButton<JoueurStatut>(
                    value: _statutSelectionne,
                    items: JoueurStatut.values.map((statut) {
                      return DropdownMenuItem(
                        value: statut,
                        child: Text(statut.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _statutSelectionne = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 6),

              TextButton(
                onPressed: _ajouterJoueur,
                child: Text(AppLocalizations.of(context)!.addjoueur),
              ),
            ] else ...[

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _licenceControleur,
                keyboardType: TextInputType.number,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labellicence,
                  //"N° Licence",
                  hintText: AppLocalizations.of(context)!.hintlicence,
                  //'1059969',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [FilteringTextInputFormatter.allow("a-zA-Z")],
                controller: _nomControleur,
                keyboardType: TextInputType.name,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labelnom,
                  //'Nom',
                  hintText: AppLocalizations.of(context)!.labelnom,
                  //'Ex: LABRIQUE',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [FilteringTextInputFormatter.allow("a-zA-Z")],
                controller: _prenomControleur,
                keyboardType: TextInputType.name,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labelprenom,
                  //'Prénom',
                  hintText: AppLocalizations.of(context)!.hintprenom,
                  //'Ex: Bob',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _poidsControleur,
                keyboardType: TextInputType.number,
                //Permet de définir le type de clavier à afficher
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labelpoids,
                  //'Poids (kg)',
                  hintText: AppLocalizations.of(context)!.hintpoids,
                  //'Entre 30 et 300 kg',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _tailleControleur,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.labeltaille,
                  //'Taille (cm)'
                  hintText: AppLocalizations.of(context)!.hinttaille,
                  //'Entre 50 et 250 cm',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.labeldate),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: _selectDate,
                    child: Text(
                      _dateNaissance != null
                          ? DateFormat('dd/MM/yyyy').format(_dateNaissance!)
                          : "dd/MM/yyyy",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              DropdownButton<JoueurStatut>(
                value: _statutSelectionne,
                items: JoueurStatut.values.map((statut) {
                  return DropdownMenuItem(
                    value: statut,
                    child: Text(statut.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _statutSelectionne = value;
                  });
                },
              ),

              const SizedBox(height: 6),

              TextButton(
                onPressed: _modifierJoueur,
                child: Text(AppLocalizations.of(context)!.modifierjoueur),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
