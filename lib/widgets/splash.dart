// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:berlin_transport/data/models.dart';
import 'package:berlin_transport/widgets/animations.dart';
import 'package:berlin_transport/data/localization.dart';
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
              fit: BoxFit.contain,
            ),
          ),
          Flexible(
            flex: 2,
            child: Consumer<AppStateNotifier>(
              builder: (context, notifier, _) => RaisedButton(
                    color: berlinDarkYellow,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      AppLocalizations.of(context).tapContinue,
                      style: TextStyle(color: Colors.black54),
                    ),
                    onPressed: () => notifier.hideSplash(),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
