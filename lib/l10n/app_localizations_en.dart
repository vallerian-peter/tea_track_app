// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'TeaTrack';

  @override
  String get appTagline => 'From Farmers to Factories';

  @override
  String get getStarted => 'Get started';

  @override
  String get signIn => 'Sign In';

  @override
  String get logout => 'Log out';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get skip => 'Skip';

  @override
  String get continueLabel => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get chooseLanguage => 'What is your preferred language?';

  @override
  String get englishLabel => 'English';

  @override
  String get swahiliLabel => 'Kiswahili';

  @override
  String get theme => 'Theme';

  @override
  String get lightMode => 'Light';

  @override
  String get darkMode => 'Dark';

  @override
  String get systemMode => 'System';

  @override
  String get requiredField => 'This field is required';

  @override
  String get offlineBannerMessage =>
      'You are offline. Changes will sync once connected.';

  @override
  String get connectionRestored => 'Internet connection restored!';

  @override
  String appVersion(String version) {
    return 'App Version: $version';
  }

  @override
  String get featureOneTitle => 'Better\nTea Supply Chain\nManagement';

  @override
  String get featureOneBody =>
      'Register farmers, farms and collection centres, and connect AMCOS, transporters and factories in one transparent chain.';

  @override
  String get featureTwoTitle => 'Same-Day\nMovement to\nthe Factory';

  @override
  String get featureTwoBody =>
      'Record weight and moisture for every bag, assign drivers and track each trip until the factory re-weighs and stocks it.';

  @override
  String get featureThreeTitle => 'Fair Payments\nand Clear\nFarmer Accounts';

  @override
  String get featureThreeBody =>
      'Factories pay AMCOS per kilogram, with invoices, balances and input debts deducted automatically from each farmer\'s account.';

  @override
  String get howItWorks => 'How it works';

  @override
  String get stepDone => 'Done';

  @override
  String get stepCurrent => 'Current';

  @override
  String get selectOption => 'Select an option';

  @override
  String get selectDate => 'Select date';

  @override
  String get selectCountryCode => 'Select country code';

  @override
  String get search => 'Search...';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get nothingHereYet => 'Nothing here yet';

  @override
  String welcomeMessage(String name) {
    return 'Welcome, $name';
  }
}
