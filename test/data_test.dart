// Data class/models tests

import 'package:flutter_test/flutter_test.dart';

import 'package:berlin_transport/data/data.dart';

void main() {
  test('Location classes build from valid, parsed json', () {
    final jsonMap = {
      'type': 'location',
      'id': '45',
      'name': 'somewhere',
      'latitude': 23.0,
      'longitude': 45,
    };
    final location = Place.fromJson(jsonMap);

    expect(location.id, '45');
    expect(location.name, 'somewhere');
    expect(location.coordinates.lat, 23.0);
    expect(location.coordinates.lng, 45.0);
  });

  test('Line classes build from valid, parsed json', () {
    final jsonMap = {
      'type': 'line',
      'id': '400',
      'fahrtNr': null,
      'name': '400',
      'public': true,
      'class': 8,
      'mode': 'bus',
      'product': 'bus',
      'symbol': null,
      'nr': 400,
      'metro': false,
      'express': false,
      'night': false
    };

    final line = Line.fromJson(jsonMap);

    expect(line.id, '400');
    expect(line.name, '400');
    expect(line.type, StopType.bus);
  });

  test('Stop classes build from valid, parsed json', () {
    final jsonMap = {
      'type': 'stop',
      'id': '55',
      'name': 'bus stop',
      'location': {
        'type': 'location',
        'latitude': 132.786,
        'longitude': 1,
      },
      'products': {
        'suburban': true,
        'subway': false,
        'tram': false,
        'bus': true,
        'ferry': false,
        'express': true,
        'regional': false
      },
      'lines': [
        {
          'type': 'line',
          'id': '400',
          'fahrtNr': null,
          'name': '400',
          'public': true,
          'class': 8,
          'mode': 'bus',
          'product': 'bus',
          'symbol': null,
          'nr': 400,
          'metro': false,
          'express': false,
          'night': false
        },
        {
          'type': 'line',
          'id': '401',
          'fahrtNr': null,
          'name': '401',
          'public': true,
          'class': 8,
          'mode': 'subway',
          'product': 'subway',
          'symbol': null,
          'nr': 401,
          'metro': false,
          'express': false,
          'night': false
        },
      ],
    };

    final stop = Stop.fromJson(jsonMap);

    expect(stop.id, '55');
    expect(stop.name, 'bus stop');
    expect(stop.coordinates.lat, 132.786);
    expect(stop.coordinates.lng, 1.0);
    expect(stop.types.contains(StopType.suburban), true);
    expect(stop.types.contains(StopType.bus), true);
    expect(stop.types.contains(StopType.express), true);
    expect(stop.types.contains(StopType.subway), false);

    // Check the lines
    expect(stop.lines.length, 2);
    expect(stop.lines[0].id, '400');
    expect(stop.lines[0].name, '400');
    expect(stop.lines[0].type, StopType.bus);
    expect(stop.lines[1].id, '401');
    expect(stop.lines[1].name, '401');
    expect(stop.lines[1].type, StopType.subway);
  });
}
