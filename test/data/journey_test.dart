// Journey data type tests

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:berlin_transport/data/data.dart';

void main() {
  Map<String, dynamic> journeyJson;
  List<dynamic> journeyListJson;

  setUpAll(() {
    // Load json data
    journeyJson = json.decode(
      File('test/assets/journey.json').readAsStringSync(),
    );
    journeyListJson = json.decode(
      File('test/assets/journey_list.json').readAsStringSync(),
    );
  });

  test('Journey classes build from valid, parsed json', () {
    final journey = Journey.fromJson(journeyJson);

    expect(journey != null, true);
    expect(journey.legs.length, 4);
    expect(journey.legs[0].origin.id, '900000215151');
    expect(journey.legs[0].destination.id, '900000215712');
  });

  test('Lists of Journey classes build from valid, parsed json', () {
    final journeys =
        journeyListJson.map<Journey>((j) => Journey.fromJson(j)).toList();

    expect(journeys != null, true);
    expect(journeys.length, 5);
    expect(journeys[0].legs.length, 3);
    expect(journeys[0].legs[0].origin.id, '900000215151');
    expect(journeys[0].legs[0].destination.id, '900000215455');
  });
}
