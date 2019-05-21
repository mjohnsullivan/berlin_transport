import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello': 'Hello World',
      'title': 'Berlin Transport App',
      'searchHintText': 'Please enter a search term',
    },
    'de': {
      'hello': 'Hallo Welt',
      'title': 'Berliner Verkehr App',
      'searchHintText': 'Bitte geben Sie einen Suchbegriff ein',
    },
  };

  String get title => _localizedValues[locale.languageCode]['title'];
  String get hello => _localizedValues[locale.languageCode]['hello'];
  String get searchHintText =>
      _localizedValues[locale.languageCode]['searchHintText'];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
