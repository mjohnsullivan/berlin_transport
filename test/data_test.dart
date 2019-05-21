// Data class/models tests

import 'package:flutter_test/flutter_test.dart';

import 'package:berlin_transport/data.dart';

void main() {
  test('Location classes built from valid json', () {
    final jsonMap = {
      'type': 'location',
      'id': '45',
      'name': 'somewhere',
      'latitude': 23.0,
      'longitude': 45,
    };
    final location = Location.fromJson(jsonMap);

    expect(location.id, 45);
    expect(location.name, 'somewhere');
    expect(location.coordinates.lat, 23.0);
    expect(location.coordinates.lng, 45.0);
  });
}
