// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:berlin_transport/models.dart';
import 'package:berlin_transport/animations.dart';
import 'package:berlin_transport/localization.dart';
import 'package:berlin_transport/theme.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: berlinBrightYellow,
      body: Column(
        children: [
          Flexible(
            flex: 8,
            child: TransportAnimation(
              type: TransportAnimationType.bus,
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
    );
  }
}
