import 'dart:core';

import 'JoueurStatut.dart';


class Joueur {
  num _joueurId;
  String _nom;
  String _prenom;
  String _numeroDeLicence;
  DateTime _dateDeNaissance;
  num _tailleEnCm;
  num _poidsEnKg;
  JoueurStatut _statut;

  Joueur(
      this._joueurId,
      this._nom,
      this._prenom,
      this._numeroDeLicence,
      this._dateDeNaissance,
      this._tailleEnCm,
      this._poidsEnKg,
      JoueurStatut this._statut
      );

  num getJoueurId() {
    return this._joueurId;
  }

  void setJoueurId(int joueurId) {
    this._joueurId = joueurId;
  }

  String getNom() {
    return this._nom;
  }

  String getPrenom() {
    return this._prenom;
  }

  String getNumeroDeLicence() {
    return this._numeroDeLicence;
  }

  DateTime getDateDeNaissance() {
    return this._dateDeNaissance;
  }

  num getTailleEnCm() {
    return this._tailleEnCm;
  }

  num getPoidsEnKg() {
    return this._poidsEnKg;
  }

  JoueurStatut getStatut() {
    return this._statut;
  }

  void setNom(String nom) {
    this._nom = nom;
  }

  void setPrenom(String prenom) {
    this._prenom = prenom;
  }

  void setNumeroDeLicence(String numeroDeLicence) {
    this._numeroDeLicence = numeroDeLicence;
  }

  void setDateDeNaissance(DateTime dateDeNaissance) {
    this._dateDeNaissance = dateDeNaissance;
  }

  void setTailleEnCm(int tailleEnCm) {
    this._tailleEnCm = tailleEnCm;
  }

  void setPoidsEnKg(int poidsEnKg) {
    this._poidsEnKg = poidsEnKg;
  }

  void setStatut(JoueurStatut statut) {
    this._statut = statut;
  }

  Map<String,String> toArray() {
    Map<String,String> array_joueur = <String,String>{};
    array_joueur.addEntries({"id":this._joueurId.toString()}.entries);
    array_joueur.addEntries({"nom":this._nom}.entries);
    array_joueur.addEntries({"prenom":this._prenom}.entries);
    array_joueur.addEntries({"numeroDeLicence":this._dateDeNaissance.toString()}.entries);
    array_joueur.addEntries({"tailleEnCm":this._tailleEnCm.toString()}.entries);
    array_joueur.addEntries({"poidsEnKg":this._poidsEnKg.toString()}.entries);
    array_joueur.addEntries({"statut":this._statut.toString()}.entries);
    return array_joueur;
  }
}

