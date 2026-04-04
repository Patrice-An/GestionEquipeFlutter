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
  String get failaddplayerlicence => 'La licence doit etre un nombre';

  @override
  String get failaddplayernom => 'Le nom ne peut pas etre vide';

  @override
  String get failaddplayerprenom => 'Le prenom ne peut pas etre vide';

  @override
  String get failaddplayerpoids => 'Le poids doit etre un nombre';

  @override
  String get failaddplayertaille => 'La taille doit etre un nombre';

  @override
  String get failaddplayerdate => 'La date de naissance ne doit pas etre vide';

  @override
  String get failaddplayerstatut => 'Le statut du joueur est incorrect';

  @override
  String get failaddplayer => 'Echec de l\'ajout du joueur';

  @override
  String get successaddplayer => 'Ajout du joueur réussi!';

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
}
