// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:berlin_transport/localization.dart';
import 'package:berlin_transport/models.dart';
import 'package:berlin_transport/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: BerlinTransportPage(),
    );
  }
}

class BerlinTransportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: ChangeNotifierProvider(
        builder: (context) => PlacesNotifier(),
        child: Column(
          children: [
            SearchBox(),
            Expanded(
              child: PlacesList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlacesNotifier>(
      builder: (context, notifier, _) {
        return ListView(
          children:
              notifier.places.map<Widget>((p) => PlaceOrStopTile(p)).toList(),
        );
      },
    );
  }
}

class PlaceOrStopTile extends StatelessWidget {
  PlaceOrStopTile(this.place);
  final Place place;

  @override
  Widget build(BuildContext context) =>
      (place is Stop) ? StopTile(place as Stop) : PlaceTile(place);
}

class PlaceTile extends StatelessWidget {
  PlaceTile(this.place);
  final Place place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.name),
      leading: Icon(Icons.home),
    );
  }
}

class StopTile extends StatelessWidget {
  StopTile(this.stop);
  final Stop stop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stop.name),
      leading: Icon(Icons.train),
      subtitle: Text(
        stop.typesAsStrings.join(', '),
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.of(context).searchHintText,
            ),
          ),
        ),
        FlatButton.icon(
          icon: Icon(Icons.search),
          label: Text(AppLocalizations.of(context).search),
          onPressed: () => _controller.text != null
              ? Provider.of<PlacesNotifier>(context).search(_controller.text)
              : null,
        ),
      ],
    );
  }
}
