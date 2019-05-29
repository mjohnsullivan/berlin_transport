import 'package:flutter/material.dart';

import 'package:berlin_transport/theme.dart' as theme;

class DestinationSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return theme.appTheme;
  }

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
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: theme.berlinBrightYellow,
      child: Center(
        child: Text('Query length: ${query.length}'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: theme.berlinBrightYellow,
      child: Center(
        child: Text('Searching ...'),
      ),
    );
  }
}
