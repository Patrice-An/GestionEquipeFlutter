// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get accueil => 'Home';

  @override
  String get nojoueurfound => 'No player found!';

  @override
  String get norencontrefound => 'No match found!';

  @override
  String get listjoueur => 'Players list';

  @override
  String get listrencontre => 'Matches List';

  @override
  String get addrencontre => 'Add a match';

  @override
  String get addjoueur => 'Add a player';

  @override
  String get mainmenu => 'Main Menu';

  @override
  String get failaddjoueurlicence => 'The licence must be a number';

  @override
  String get failaddjoueurnom => 'The name can\'t be empty';

  @override
  String get failaddjoueurprenom => 'The first name can\'t be empty';

  @override
  String get failaddjoueurpoids => 'The weight must be a number';

  @override
  String get failaddjoueurtaille => 'The height must be a number';

  @override
  String get failaddjoueurdate => 'The birth date can\'t be empty';

  @override
  String get failaddjoueurstatut => 'The status can\'t be empty';

  @override
  String get failaddjoueur => 'The player adding operation failed';

  @override
  String get successaddjoueur => 'The player has been successfully added';

  @override
  String get failaddrencontre => 'The match adding operation failed';

  @override
  String get successaddrencontre => 'The match has been successfully added';

  @override
  String get labellicence => 'Licence number';

  @override
  String get hintlicence => '1059969';

  @override
  String get labelnom => 'Last name';

  @override
  String get hintnom => 'Ex: LABRIQUE';

  @override
  String get labelprenom => 'First name';

  @override
  String get hintprenom => 'Ex: Bob';

  @override
  String get labelpoids => 'Weight (kg)';

  @override
  String get hintpoids => 'Between 30 and 300 kg';

  @override
  String get labeltaille => 'Height (cm)';

  @override
  String get hinttaille => 'Between 50 and 250 cm';

  @override
  String get labeldate => 'Birth date';

  @override
  String get failmodifjoueur => 'The player modification operation failed';

  @override
  String get successmodifjoueur => 'The player has been successfully modified';

  @override
  String get faildeletejoueur => 'The player deletion operation failed';

  @override
  String get successdeletejoueur => 'The player has been successfully deleted';

  @override
  String get failaddrencontredate => 'The match date can\'t be in the past';

  @override
  String get failaddrencontreadresse => 'The match date can\'t be in the past';

  @override
  String get failaddrencontreadv => 'The opponent licence can\'t be empty';

  @override
  String get faildeleterencontre => 'The match deletion operation failed';

  @override
  String get successdeleterencontre =>
      'The match has been successfully deleted';

  @override
  String get failmodifrencontre => 'The match modification operation failed';

  @override
  String get successmodifrencontre =>
      'The match has been successfully modified';

  @override
  String get modifiedplayer => 'Edit';

  @override
  String get deleteplayer => 'Delete';

  @override
  String get labelstatut => 'player statut';

  @override
  String get lastmatch => 'Previous match';

  @override
  String get nextmatch => 'Next Match';

  @override
  String get welcome => 'Welcome to GestEquipe !';

  @override
  String get hintadversaire => 'Opponent licence';

  @override
  String get hintadresse => 'Address';

  @override
  String get labeladversaire => 'Opponent';

  @override
  String get labeladresse => 'Address';

  @override
  String get labelresultat => 'Resultat';

  @override
  String get modifierjoueur => 'Edit player';

  @override
  String get labellieu => 'Location';

  @override
  String get failresultatrencontre => 'The result can\'t be empty';

  @override
  String get modifierrencontre => 'Edit match';

  @override
  String get modifierresultat => 'Edit';

  @override
  String get deleterencontre => 'Delete';

  @override
  String get parametres => 'Settings';

  @override
  String get optionstyle => 'Modern menu : ';
}
