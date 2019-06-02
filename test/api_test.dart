import 'package:flutter_test/flutter_test.dart';

import 'package:berlin_transport/data/api.dart';

void main() {
  test('nearbyStations returns a result', () async {
    final res = await nearbyStations(cityCubeBerlin);
    print(res);
  });

  test('station returns a result', () async {
    final id = 900000100031;
    final res = await station(id);
    print(res);
  });

  test('departures returns a result', () async {
    final id = 900000100031;
    final res = await departures(id);
    print(res);
  });

  test('journey returns a result', () async {
    final fromId = '900000100031';
    final toId = '900000100030';
    final res = await journey(fromId, toId);
    print(res);
  });

  test('locations returns a result', () async {
    final query = 'citycube';
    final res = await locations(query);
    print(res);
  });
}
