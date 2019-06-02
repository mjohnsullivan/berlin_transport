// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:berlin_transport/widgets/splash.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:berlin_transport/widgets/widgets.dart';
import 'package:berlin_transport/search.dart';
import 'package:berlin_transport/theme.dart';
import 'package:berlin_transport/widgets/prefs.dart';

import 'package:berlin_transport/localization.dart';
import 'package:berlin_transport/models.dart';
import 'package:berlin_transport/data.dart';

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
        home: OverrideLocalization(
          child: Consumer<AppStateNotifier>(
            builder: (context, notifier, _) =>
                notifier.showSplash ? SplashScreen() : BerlinTransportPage(),
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
                  icon: Icon(Icons.build),
                  onPressed: () => showPreferences(context),
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          Departure(),
          Arrival(),
          Expanded(
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                  //child: TransportAnimation(
                  //  type: randomTransportAnimationType(),
                  //),
                  ),
            ),
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
          ? Text(notifier.departure.name)
          : Text(AppLocalizations.of(context).departure),
      onTap: () => _showPlacesSearch(context).then(
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
          ? Text(notifier.arrival.name)
          : Text(AppLocalizations.of(context).arrival),
      onTap: () => _showPlacesSearch(context).then(
            (place) => notifier.arrival = place,
          ),
    );
  }
}

Future<Place> _showPlacesSearch(BuildContext context) async {
  final place = await showSearch<Place>(
    context: context,
    delegate: PlacesSearchDelegate(),
  );
  return place;
}
