// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get accueil => 'Accueil';

  @override
  String get nojoueurfound => 'Aucun joueur trouvé!';

  @override
  String get norencontrefound => 'Aucune rencontre trouvé!';

  @override
  String get listjoueur => 'Liste des Joueurs';

  @override
  String get listrencontre => 'Liste des Rencontres';

  @override
  String get addrencontre => 'Ajouter une Rencontre';

  @override
  String get addjoueur => 'Ajouter un Joueur';

  @override
  String get mainmenu => 'Menu Principal';

  @override
  String get failaddjoueurlicence => 'La licence doit être un nombre';

  @override
  String get failaddjoueurnom => 'Le nom ne peut pas être vide';

  @override
  String get failaddjoueurprenom => 'Le prénom ne peut pas être vide';

  @override
  String get failaddjoueurpoids => 'Le poids doit être un nombre';

  @override
  String get failaddjoueurtaille => 'La taille doit être un nombre';

  @override
  String get failaddjoueurdate => 'La date de naissance ne peut pas être vide';

  @override
  String get failaddjoueurstatut => 'Le statut ne peut pas être vide';

  @override
  String get failaddjoueur => 'L\'ajout du joueur a échoué';

  @override
  String get successaddjoueur => 'Le joueur a été ajouté avec succès';

  @override
  String get failaddrencontre => 'L\'ajout de la rencontre a échoué';

  @override
  String get successaddrencontre => 'Ajout de la rencontre réussie!';

  @override
  String get labellicence => 'Numéro de Licence';

  @override
  String get hintlicence => '1059969';

  @override
  String get labelnom => 'Nom';

  @override
  String get hintnom => 'Ex: LABRIQUE';

  @override
  String get labelprenom => 'Prénom';

  @override
  String get hintprenom => 'Ex: Bob';

  @override
  String get labelpoids => 'Poids (kg)';

  @override
  String get hintpoids => 'Between 30 and 300 kg';

  @override
  String get labeltaille => 'Taille (cm)';

  @override
  String get hinttaille => 'Between 50 and 250 cm';

  @override
  String get labeldate => 'Date de naissance';

  @override
  String get failmodifjoueur => 'La modification du joueur a échoué';

  @override
  String get successmodifjoueur => 'Le joueur a été modifié avec succès';

  @override
  String get faildeletejoueur => 'La suppression du joueur a échoué';

  @override
  String get successdeletejoueur => 'Le joueur a été supprimé avec succès';

  @override
  String get failaddrencontredate =>
      'La date de la rencontre ne peut pas être dans le passé';

  @override
  String get failaddrencontreadresse =>
      'La date de la rencontre ne peut pas être dans le passé';

  @override
  String get failaddrencontreadv =>
      'La licence de l\'adversaire ne peut pas être vide';

  @override
  String get faildeleterencontre => 'La suppression de la rencontre a échoué';

  @override
  String get successdeleterencontre =>
      'La rencontre a été supprimée avec succès';

  @override
  String get failmodifrencontre => 'La modification de la rencontre a échoué';

  @override
  String get successmodifrencontre => 'La rencontre a été modifiée avec succès';

  @override
  String get modifiedplayer => 'Modifier';

  @override
  String get deleteplayer => 'Supprimer';

  @override
  String get labelstatut => 'Statut du Joueur';

  @override
  String get lastmatch => 'Rencontre précédente';

  @override
  String get nextmatch => 'Prochaine rencontre';

  @override
  String get welcome => 'Bienvenue sur GestEquipe !';

  @override
  String get hintadversaire => 'Licence de l\'adversaire';

  @override
  String get hintadresse => 'Adresse';

  @override
  String get labeladversaire => 'Adversaire';

  @override
  String get labeladresse => 'Adresse';

  @override
  String get labelresultat => 'Résultat';

  @override
  String get modifierjoueur => 'Modifier le joueur';

  @override
  String get labellieu => 'Lieu';

  @override
  String get failresultatrencontre => 'Le résultat ne peut pas être vide';

  @override
  String get modifierrencontre => 'Modifier';

  @override
  String get modifierresultat => 'Modifier le résultat';

  @override
  String get deleterencontre => 'Supprimer';
}
