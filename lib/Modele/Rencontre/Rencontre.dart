import 'dart:core';

import 'RencontreLieu.dart';
import 'RencontreResultat.dart';


class Rencontre {
  num _rencontreId;
  DateTime _dateEtHeure;
  String _equipeAdverse;
  String _adresse;
  RencontreLieu _lieu;
  RencontreResultat? _resultat;

  Rencontre(
      this._rencontreId,
      this._dateEtHeure,
      this._equipeAdverse,
      this._adresse,
      this._lieu,
      this._resultat,
      );

  num getRencontreId() {
    return this._rencontreId;
  }

  void setRencontreId(int rencontreId) {
    this._rencontreId = rencontreId;
  }

  String getEquipeAdverse() {
    return this._equipeAdverse;
  }

  String getAdresse() {
    return this._adresse;
  }

  RencontreLieu getLieu() {
    return this._lieu;
  }

  DateTime getDateEtHeure() {
    return this._dateEtHeure;
  }

  RencontreResultat? getResultat() {
    return this._resultat;
  }

  void setEquipeAdverse(String adv) {
    this._equipeAdverse = adv;
  }

  void setAdresse(String adresse) {
    this._adresse = adresse;
  }

  //Au Format yyyy-mm-dd hh:mm
  void setDateEtHeure(DateTime dateEtHeure) {
    this._dateEtHeure = dateEtHeure;
  }

  void setLieu(RencontreLieu lieu) {
    this._lieu = lieu;
  }

  void setResultat(RencontreResultat? resultat) {
    this._resultat = resultat;
  }
  
  Map<String,String> toArray() {
    Map<String,String> array_rencontre = <String,String>{};
    array_rencontre.addEntries({"id":this._rencontreId.toString()}.entries);
    array_rencontre.addEntries({"nom":this._equipeAdverse}.entries);
    array_rencontre.addEntries({"prenom":this._adresse}.entries);
    array_rencontre.addEntries({"numeroDeLicence":this._dateEtHeure.toString()}.entries);
    array_rencontre.addEntries({"lieu":this._lieu.toString()}.entries);
    if(this._resultat.toString()!="null") {
      array_rencontre.addEntries({"resultat": this._resultat.toString()}.entries);
    }
    return array_rencontre;
  }
}

