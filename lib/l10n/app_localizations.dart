import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @accueil.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get accueil;

  /// No description provided for @nojoueurfound.
  ///
  /// In en, this message translates to:
  /// **'No player found!'**
  String get nojoueurfound;

  /// No description provided for @norencontrefound.
  ///
  /// In en, this message translates to:
  /// **'No match found!'**
  String get norencontrefound;

  /// No description provided for @listjoueur.
  ///
  /// In en, this message translates to:
  /// **'Players list'**
  String get listjoueur;

  /// No description provided for @listrencontre.
  ///
  /// In en, this message translates to:
  /// **'Matches List'**
  String get listrencontre;

  /// No description provided for @addrencontre.
  ///
  /// In en, this message translates to:
  /// **'Add a match'**
  String get addrencontre;

  /// No description provided for @addjoueur.
  ///
  /// In en, this message translates to:
  /// **'Add a player'**
  String get addjoueur;

  /// No description provided for @mainmenu.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get mainmenu;

  /// No description provided for @failaddplayerlicence.
  ///
  /// In en, this message translates to:
  /// **'The licence must be a number'**
  String get failaddplayerlicence;

  /// No description provided for @failaddplayernom.
  ///
  /// In en, this message translates to:
  /// **'The name can\'t be empty'**
  String get failaddplayernom;

  /// No description provided for @failaddplayerprenom.
  ///
  /// In en, this message translates to:
  /// **'The first name can\'t be empty'**
  String get failaddplayerprenom;

  /// No description provided for @failaddplayerpoids.
  ///
  /// In en, this message translates to:
  /// **'The weight must be a number'**
  String get failaddplayerpoids;

  /// No description provided for @failaddplayertaille.
  ///
  /// In en, this message translates to:
  /// **'The height must be a number'**
  String get failaddplayertaille;

  /// No description provided for @failaddplayerdate.
  ///
  /// In en, this message translates to:
  /// **'The birth date can\'t be empty'**
  String get failaddplayerdate;

  /// No description provided for @failaddplayerstatut.
  ///
  /// In en, this message translates to:
  /// **'The status can\'t be empty'**
  String get failaddplayerstatut;

  /// No description provided for @failaddplayer.
  ///
  /// In en, this message translates to:
  /// **'The player adding operation failed'**
  String get failaddplayer;

  /// No description provided for @successaddplayer.
  ///
  /// In en, this message translates to:
  /// **'The player has been successfully added'**
  String get successaddplayer;

  /// No description provided for @failaddrencontre.
  ///
  /// In en, this message translates to:
  /// **'The match adding operation failed'**
  String get failaddrencontre;

  /// No description provided for @successaddrencontre.
  ///
  /// In en, this message translates to:
  /// **'The match has been successfully added'**
  String get successaddrencontre;

  /// No description provided for @labellicence.
  ///
  /// In en, this message translates to:
  /// **'Licence number'**
  String get labellicence;

  /// No description provided for @hintlicence.
  ///
  /// In en, this message translates to:
  /// **'1059969'**
  String get hintlicence;

  /// No description provided for @labelnom.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get labelnom;

  /// No description provided for @hintnom.
  ///
  /// In en, this message translates to:
  /// **'Ex: LABRIQUE'**
  String get hintnom;

  /// No description provided for @labelprenom.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get labelprenom;

  /// No description provided for @hintprenom.
  ///
  /// In en, this message translates to:
  /// **'Ex: Bob'**
  String get hintprenom;

  /// No description provided for @labelpoids.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get labelpoids;

  /// No description provided for @hintpoids.
  ///
  /// In en, this message translates to:
  /// **'Between 30 and 300 kg'**
  String get hintpoids;

  /// No description provided for @labeltaille.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get labeltaille;

  /// No description provided for @hinttaille.
  ///
  /// In en, this message translates to:
  /// **'Between 50 and 250 cm'**
  String get hinttaille;

  /// No description provided for @labeldate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get labeldate;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
