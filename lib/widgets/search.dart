// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:berlin_transport/data/models.dart';
import 'package:berlin_transport/data/data.dart';
import 'package:berlin_transport/theme.dart' as theme;

Future<Place> showPlacesSearch(BuildContext context) async =>
    await showSearch<Place>(
      context: context,
      delegate: PlacesSearchDelegate(),
    );

class PlacesSearchDelegate extends SearchDelegate<Place> {
  @override
  ThemeData appBarTheme(BuildContext context) => theme.appTheme;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final notifier = Provider.of<JourneyNotifier>(context);
    return FutureBuilder(
        future: notifier.searchPlaces(query),
        builder: (context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: theme.berlinBrightYellow,
              child: ListView(
                children: snapshot.data
                    .map(
                      (p) => (p is Stop)
                          ? StopTile(
                              stop: p,
                              onTap: () => close(context, p),
                            )
                          : PlaceTile(
                              place: p,
                              onTap: () => close(context, p),
                            ),
                    )
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              color: theme.berlinBrightYellow,
              child: Center(
                child: Text(
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return Container(
              color: theme.berlinBrightYellow,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: theme.berlinBrightYellow,
      child: Center(
        child: Opacity(
            opacity: 0.2,
            child: Icon(
              Icons.directions_railway,
              size: 200,
            )),
      ),
    );
  }
}

/// Tile depicting a place
class PlaceTile extends StatelessWidget {
  PlaceTile({this.place, this.onTap});
  final Place place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.name),
      leading: Icon(Icons.home),
      onTap: onTap,
    );
  }
}

/// Tile depicting a stop
class StopTile extends StatelessWidget {
  StopTile({this.stop, this.onTap});
  final Stop stop;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stop.name),
      leading: const Icon(Icons.train),
      subtitle: Text(stop.typesAsStrings.join(', ')),
      onTap: onTap,
    );
  }
}
