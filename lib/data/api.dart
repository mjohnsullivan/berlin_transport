// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// See https://github.com/derhuerst/bvg-rest/blob/master/docs/index.md
/// for api info

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:berlin_transport/data/data.dart';

class LatLng {
  const LatLng({this.lat, this.lng});
  final double lat;
  final double lng;
}

const cityCubeBerlin = LatLng(lat: 52.523430, lng: 13.411440);
const urlPrefix = 'https://1.bvg.transport.rest';

/// Retrieves all stations near a given position
///
/// curl 'https://1.bvg.transport.rest/stations/nearby?latitude=52.52725&longitude=13.4123'
Future<String> nearbyStations(LatLng latLng) async {
  final url = urlPrefix +
      '/stations/nearby' +
      '?latitude=${latLng.lat}' +
      '&longitude=${latLng.lng}';

  return _fetchData(url);
}

/// Retrieves data regarding the specified station
///
/// curl 'https://1.bvg.transport.rest/stations/900000013102'
Future<String> station(int id) async {
  final url = urlPrefix + '/stations/$id';
  return _fetchData(url);
}

/// Retrieves current departures for a station
///
/// curl 'https://1.bvg.transport.rest/stations/900000013102/departures?when=tomorrow%206pm'
Future<String> departures(int stationId) async {
  final url = urlPrefix + '/stations/$stationId/departures';
  return _fetchData(url);
}

/// Retrieves journey data from and to specified stations
///
/// curl 'https://1.bvg.transport.rest/journeys?from=900000017104&to=900000017101'
Future<List<Journey>> journey(String fromId, String toId) async {
  final url = urlPrefix + '/journeys?from=$fromId&to=$toId';
  print(url);
  final body = await _fetchData(url);
  return (json.decode(body) as List)
      .map<Journey>((j) => Journey.fromJson(j))
      .toList();
}

/// Searches for locations given a query string
///
/// curl 'https://1.bvg.transport.rest/locations?query=citycube'
Future<List<Place>> locations(String query) async {
  final url = urlPrefix +
      '/locations?query=$query' +
      '&stationLines=true' +
      '&results=10';
  final body = await _fetchData(url);
  return (json.decode(body) as List)
      .map<Place>((p) => Place.fromJson(p))
      .where((p) => p != null) // filter out nulls
      .toList();
}

/// Fetches data from a url over http
/// Throws a HttpException if 200 is not returned
Future<String> _fetchData(String url) async {
  final res = await http.get(url);

  if (res.statusCode != 200) {
    print('Error ${res.statusCode}: $url');
    throw HttpException(
      'Invalid response ${res.statusCode}',
      uri: Uri.parse(url),
    );
  }
  return res.body;
}
