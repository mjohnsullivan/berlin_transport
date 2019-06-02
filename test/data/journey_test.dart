// Journey data type tests

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:berlin_transport/data/data.dart';

void main() {
  Map<String, dynamic> journeyJson;

  setUpAll(() {
    // Load json data
    journeyJson = json.decode(
      File('test/assets/journey.json').readAsStringSync(),
    );
  });

  test('Leg classes build from valid, parsed json', () {
    final journey = Journey.fromJson(journeyJson);

    expect(journey != null, true);
    expect(journey.legs.length, 1);
    expect(journey.legs[0].origin.id, '900000025423');
    expect(journey.legs[0].destination.id, '900000100003');
  });
}
