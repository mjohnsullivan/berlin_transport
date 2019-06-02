// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Middleware that manages interactions between ui and api

import 'dart:ui';
import 'package:flutter/foundation.dart';

import 'package:berlin_transport/data.dart';

/// Journey data
class JourneyNotifier with ChangeNotifier {
  // Depature data
  Place _departure;
  Place get departure => _departure;
  set departure(Place place) {
    _departure = place;
    notifyListeners();
  }

  // Arrival data
  Place _arrival;
  Place get arrival => _arrival;
  set arrival(Place place) {
    _arrival = place;
    notifyListeners();
  }
}

/// Preferences
class PrefsNotifier with ChangeNotifier {
  // Offline
  bool _offline = false;
  bool get offline => _offline;
  set offline(bool value) {
    _offline = offline;
    notifyListeners();
  }

  // Locale
  Locale _locale;
  Locale get locale => _locale;
  set locale(Locale value) {
    _locale = value;
    notifyListeners();
  }
}

/// App state
class AppStateNotifier with ChangeNotifier {
  // Splash screen
  bool _showSplash = true;
  bool get showSplash => _showSplash;
  hideSplash() {
    _showSplash = false;
    notifyListeners();
  }
}
