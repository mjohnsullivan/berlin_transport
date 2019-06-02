// Leg data type tests

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:berlin_transport/data/data.dart';

void main() {
  Map<String, dynamic> legJson;

  setUpAll(() {
    // Load json data
    legJson = json.decode(
      File('test/assets/leg.json').readAsStringSync(),
    );
  });

  test('Leg classes build from valid, parsed json', () {
    final leg = Leg.fromJson(legJson);

    expect(leg != null, true);
    expect(leg.origin.id, '900000025423');
    expect(leg.destination.id, '900000100003');
    expect(leg.departureTime, DateTime.utc(2019, 6, 2, 13, 30));
    expect(leg.arrivalTime, DateTime.utc(2019, 6, 2, 13, 51));
    expect(leg.line.name, 'S9');
    expect(leg.direction, 'S Flughafen Berlin-Schönefeld');
  });
}
