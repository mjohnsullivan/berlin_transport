// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const _localizedValues = {
    'en': {
      'hello': 'Hello World',
      'title': 'Berlin Transport App',
      'search': 'Search',
      'searching_message': 'searching ...',
      'departure': 'Departure',
      'arrival': 'Arrival',
      'searchHintText': 'Please enter a search term',
      'offline': 'offline',
      'preferences': 'Preferences',
      'language': 'Language',
      'english': 'English',
      'german': 'German',
      'tap_continue': 'Tap to continue',
    },
    'de': {
      'hello': 'Hallo Welt',
      'title': 'Berliner Verkehr App',
      'search': 'Suche',
      'searching_message': 'suche ...',
      'departure': 'Abfahrt',
      'arrival': 'Ankunft',
      'searchHintText': 'Bitte geben Sie einen Suchbegriff ein',
      'offline': 'offline',
      'preferences': 'Vorlieben',
      'language': 'Sprache',
      'english': 'Englisch',
      'german': 'Deutsche',
      'tap_continue': 'Tippen Sie, um fortzufahren',
    },
  };

  String get title => _localizedValues[locale.languageCode]['title'];
  String get hello => _localizedValues[locale.languageCode]['hello'];
  String get search => _localizedValues[locale.languageCode]['search'];
  String get searchMessage =>
      _localizedValues[locale.languageCode]['searching_message'];
  String get departure => _localizedValues[locale.languageCode]['departure'];
  String get arrival => _localizedValues[locale.languageCode]['arrival'];
  String get searchHintText =>
      _localizedValues[locale.languageCode]['searchHintText'];
  String get offline => _localizedValues[locale.languageCode]['offline'];
  String get preferences =>
      _localizedValues[locale.languageCode]['preferences'];
  String get language => _localizedValues[locale.languageCode]['language'];
  String get english => _localizedValues[locale.languageCode]['english'];
  String get german => _localizedValues[locale.languageCode]['german'];
  String get tapContinue =>
      _localizedValues[locale.languageCode]['tap_continue'];
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
