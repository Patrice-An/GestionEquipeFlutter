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
  String get failaddplayerlicence => 'The licence must be a number';

  @override
  String get failaddplayernom => 'The name can\'t be empty';

  @override
  String get failaddplayerprenom => 'The first name can\'t be empty';

  @override
  String get failaddplayerpoids => 'The weight must be a number';

  @override
  String get failaddplayertaille => 'The height must be a number';

  @override
  String get failaddplayerdate => 'The birth date can\'t be empty';

  @override
  String get failaddplayerstatut => 'The status can\'t be empty';

  @override
  String get failaddplayer => 'The player adding operation failed';

  @override
  String get successaddplayer => 'The player has been successfully added';

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
}
