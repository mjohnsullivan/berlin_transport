// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Middleware that manages interactions between ui and api

import 'package:flutter/foundation.dart';

import 'package:berlin_transport/api.dart';
import 'package:berlin_transport/data.dart';

class PlacesNotifier with ChangeNotifier {
  var _places = <Place>[];
  List<Place> get places => _places;

  void search(String query) async {
    _places = await locations(query);
    notifyListeners();
  }
}
