// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Pre-cached api results for testing/offline demonstration

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:berlin_transport/data/data.dart';

/// Loads a cached origin place
Future<Place> get origin async => Place.fromJson(
      json.decode(
        await rootBundle.loadString('assets/origin.json'),
      ),
    );

/// Loads a cached destination place
Future<Place> get destination async => Place.fromJson(
      json.decode(
        await rootBundle.loadString('assets/destination.json'),
      ),
    );

/// Loads a cached location search for origin
Future<List<Place>> get locationOrigin async =>
    (json.decode(await rootBundle.loadString(
      'assets/location_origin.json',
    )) as List)
        .map<Place>((p) => Place.fromJson(p))
        .where((p) => p != null) // filter out nulls
        .toList();

/// Loads a cached location search for destination
Future<List<Place>> get locationDestination async =>
    (json.decode(await rootBundle.loadString(
      'assets/location_destination.json',
    )) as List)
        .map<Place>((p) => Place.fromJson(p))
        .where((p) => p != null) // filter out nulls
        .toList();

/// Loads a cached journey
Future<List<Journey>> get journey async =>
    (json.decode(await rootBundle.loadString(
      'assets/journey.json',
    )) as List)
        .map<Journey>((j) => Journey.fromJson(j))
        .toList();
