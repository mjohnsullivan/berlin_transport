/// Preferences widget

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:berlin_transport/localization.dart';
import 'package:berlin_transport/models.dart';

void showPreferences(BuildContext context) {
  showModalBottomSheet(context: context, builder: (context) => Preferences());
}

class Preferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            AppLocalizations.of(context).preferences,
            style: Theme.of(context).textTheme.display1,
            textAlign: TextAlign.left,
          ),
        ),
        LocalePref(),
        Offline(),
      ],
    );
  }
}

class LocalePref extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Consumer<PrefsNotifier>(
        builder: (context, notifier, _) => Row(
              children: [
                Expanded(child: Text(AppLocalizations.of(context).language)),
                Radio(
                  value: 0,
                  groupValue: 0,
                  onChanged: (val) {},
                ),
                Text(AppLocalizations.of(context).english),
                Radio(
                  value: 1,
                  groupValue: 0,
                  onChanged: (val) {},
                ),
                Text(AppLocalizations.of(context).german),
              ],
            ),
      ),
    );
    ;
  }
}

class Offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(child: Text(AppLocalizations.of(context).offline)),
          Consumer<PrefsNotifier>(
            builder: (context, notifier, _) => Switch(
                  value: notifier.offline,
                  onChanged: (val) => notifier.offline = val,
                ),
          )
        ],
      ),
    );
  }
}
