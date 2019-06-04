// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_web/material.dart';

import 'package:provider/provider.dart';

import 'package:berlin_transport/data/models.dart';
import 'package:berlin_transport/data/localization.dart';
import 'package:berlin_transport/theme.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: berlinBrightYellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 8,
              child: Icon(
                Icons.directions_bus,
                size: 200,
              ),
            ),
            Flexible(
              flex: 2,
              child: Consumer<AppStateNotifier>(
                builder: (context, notifier, _) => FlatButton(
                      child: Text(AppLocalizations.of(context).tapContinue),
                      onPressed: () => notifier.hideSplash(),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
