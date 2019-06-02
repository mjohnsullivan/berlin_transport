// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:berlin_transport/widgets/widgets.dart';
import 'package:berlin_transport/widgets/search.dart';
import 'package:berlin_transport/theme.dart';
import 'package:berlin_transport/widgets/prefs.dart';
import 'package:berlin_transport/widgets/splash.dart';
import 'package:berlin_transport/widgets/journey.dart';

import 'package:berlin_transport/data/localization.dart';
import 'package:berlin_transport/data/models.dart';
import 'package:berlin_transport/data/data.dart' as data;

void main() => runApp(BerlinTransportApp());

class BerlinTransportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => PrefsNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (_) => JourneyNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (_) => AppStateNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context).title,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('de'),
        ],
        theme: appTheme,
        home: Consumer<PrefsNotifier>(
          builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: Consumer<AppStateNotifier>(
                  builder: (context, notifier, _) => notifier.showSplash
                      ? SplashScreen()
                      : BerlinTransportPage(),
                ),
              ),
        ),
      ),
    );
  }
}

class BerlinTransportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: berlinBrightYellow,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
        actions: [
          Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => showPreferences(context),
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          Departure(),
          SizedBox(height: 15),
          Arrival(),
          SizedBox(height: 15),
          Expanded(
            child: JourneyPanel(),
          ),
        ],
      ),
    );
  }
}

class Departure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<JourneyNotifier>(context);
    return GestureDetector(
      child: notifier.departure != null
          ? EmbossedText(notifier.departure.name)
          : EmbossedText(AppLocalizations.of(context).departure),
      onTap: () => showPlacesSearch(context).then(
            (place) => notifier.departure = place,
          ),
    );
  }
}

class Arrival extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<JourneyNotifier>(context);
    return GestureDetector(
      child: notifier.arrival != null
          ? EmbossedText(notifier.arrival.name)
          : EmbossedText(AppLocalizations.of(context).arrival),
      onTap: () => showPlacesSearch(context).then(
            (place) => notifier.arrival = place,
          ),
    );
  }
}

class EmbossedText extends StatelessWidget {
  const EmbossedText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          color: berlinBrightYellow,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

class JourneyPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JourneyNotifier>(
      builder: (context, notifier, _) => notifier.journeys != null
          ? JourneyList(notifier.journeys)
          : Container(
              child: Center(
                child: Text('No journey data yet'),
              ),
            ),
    );
  }
}

class JourneyList extends StatelessWidget {
  JourneyList(this.journeys);
  final List<data.Journey> journeys;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: journeys.map<Journey>((j) => Journey(j)).toList(),
    );
  }
}
