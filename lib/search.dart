import 'package:berlin_transport/data.dart';
import 'package:flutter/material.dart';

import 'package:berlin_transport/api.dart';
import 'package:berlin_transport/localization.dart';

import 'package:berlin_transport/theme.dart' as theme;

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
    return FutureBuilder(
        future: locations(query),
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
        child: Text(AppLocalizations.of(context).searchMessage),
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
      leading: Icon(Icons.train),
      subtitle: Text(stop.typesAsStrings.join(', ')),
      onTap: onTap,
    );
  }
}
