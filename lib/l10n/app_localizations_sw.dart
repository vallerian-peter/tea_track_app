// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appName => 'TeaTrack';

  @override
  String get appTagline => 'Kutoka kwa Wakulima hadi Viwandani';

  @override
  String get getStarted => 'Anza';

  @override
  String get signIn => 'Ingia';

  @override
  String get logout => 'Toka';

  @override
  String get next => 'Endelea';

  @override
  String get back => 'Rudi';

  @override
  String get skip => 'Ruka';

  @override
  String get continueLabel => 'Endelea';

  @override
  String get cancel => 'Ghairi';

  @override
  String get save => 'Hifadhi';

  @override
  String get changeLanguage => 'Badilisha lugha';

  @override
  String get chooseLanguage => 'Ungependa kutumia lugha gani?';

  @override
  String get englishLabel => 'English';

  @override
  String get swahiliLabel => 'Kiswahili';

  @override
  String get theme => 'Mandhari';

  @override
  String get lightMode => 'Mwanga';

  @override
  String get darkMode => 'Giza';

  @override
  String get systemMode => 'Mfumo';

  @override
  String get requiredField => 'Sehemu hii inahitajika';

  @override
  String get offlineBannerMessage =>
      'Huna mtandao. Mabadiliko yatasawazishwa ukiunganishwa.';

  @override
  String get connectionRestored => 'Mtandao umerejea!';

  @override
  String appVersion(String version) {
    return 'Toleo la Programu: $version';
  }

  @override
  String get featureOneTitle => 'Usimamizi Bora\nwa Mnyororo wa\nUgavi wa Chai';

  @override
  String get featureOneBody =>
      'Sajili wakulima, mashamba na vituo vya ukusanyaji, na unganisha AMCOS, wasafirishaji na viwanda kwa uwazi.';

  @override
  String get featureTwoTitle => 'Usafirishaji\nwa Siku Hiyo\nHadi Kiwandani';

  @override
  String get featureTwoBody =>
      'Rekodi uzito na unyevu wa kila gunia, panga madereva na fuatilia kila safari hadi kiwanda kipime upya na kuhifadhi.';

  @override
  String get featureThreeTitle =>
      'Malipo ya Haki\nna Akaunti Wazi\nza Wakulima';

  @override
  String get featureThreeBody =>
      'Viwanda hulipa AMCOS kwa kila kilo, pamoja na ankara, salio na madeni ya pembejeo kukatwa moja kwa moja kwenye akaunti ya mkulima.';

  @override
  String get howItWorks => 'Jinsi inavyofanya kazi';

  @override
  String get stepDone => 'Imekamilika';

  @override
  String get stepCurrent => 'Sasa';

  @override
  String get selectOption => 'Chagua chaguo';

  @override
  String get selectDate => 'Chagua tarehe';

  @override
  String get selectCountryCode => 'Chagua msimbo wa nchi';

  @override
  String get search => 'Tafuta...';

  @override
  String get pleaseWait => 'Tafadhali subiri...';

  @override
  String get nothingHereYet => 'Hakuna kitu bado';

  @override
  String welcomeMessage(String name) {
    return 'Karibu, $name';
  }
}
