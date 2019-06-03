// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Preferences widget

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:berlin_transport/widgets/widgets.dart';
import 'package:berlin_transport/data/localization.dart';
import 'package:berlin_transport/data/models.dart';

void showPreferences(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Preferences(),
  );
}

class Preferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PrefsNotifier>(
      builder: (context, notifier, _) => OverrideLocalization(
            locale: notifier.locale,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Builder(
                    builder: (context) => Text(
                          AppLocalizations.of(context).preferences,
                          style: Theme.of(context).textTheme.display1,
                          textAlign: TextAlign.left,
                        ),
                  ),
                ),
                LocalePref(),
                OfflinePref(),
                SplashPref(),
              ],
            ),
          ),
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
                  groupValue: notifier.localeSelector,
                  onChanged: (val) => notifier.localeSelector = 0,
                ),
                Text(AppLocalizations.of(context).english),
                Radio(
                  value: 1,
                  groupValue: notifier.localeSelector,
                  onChanged: (val) => notifier.localeSelector = 1,
                ),
                Text(AppLocalizations.of(context).german),
              ],
            ),
      ),
    );
  }
}

class OfflinePref extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(child: Text(AppLocalizations.of(context).offline)),
          Consumer<JourneyNotifier>(
            builder: (context, notifier, _) => Switch(
                  value: notifier.useCache,
                  onChanged: (val) => notifier.useCache = val,
                ),
          )
        ],
      ),
    );
  }
}

class SplashPref extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<AppStateNotifier>(
            builder: (context, notifier, _) => IconButton(
                  icon: Icon(Icons.restore, size: 15, color: Colors.grey),
                  onPressed: () => notifier.resetSplash(),
                ),
          )
        ],
      ),
    );
  }
}
