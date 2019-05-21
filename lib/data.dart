/// Data types/models
import 'package:meta/meta.dart';

/// Data type for latitude/longitude
class LatLng {
  const LatLng({this.lat, this.lng});
  final double lat;
  final double lng;
}

/// Data type for locations
class Location {
  const Location({@required this.id, this.name, this.coordinates});
  final int id;
  final String name;
  final LatLng coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'location');
    return Location(
      id: int.parse(json['id'] as String),
      name: json['name'] as String,
      coordinates: LatLng(
        lat: (json['latitude'] as num).toDouble(),
        lng: (json['longitude'] as num).toDouble(),
      ),
    );
  }
}

/// A transport line or route
class Line {
  const Line({
    @required this.id,
    @required this.name,
    @required this.type,
  });
  final int id;
  final String name;
  final StopType type;

  factory Line.fromJson(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'line');
    return Line(
      id: int.parse(json['id'] as String),
      name: json['name'] as String,
      type: _stopTypeFromString(json['product']),
    );
  }
}

/// Data type for a transportation stop
class Stop {
  const Stop({
    @required this.id,
    @required this.name,
    @required this.coordinates,
    @required this.types,
    @required this.lines,
  });
  final int id;
  final String name;
  final LatLng coordinates;
  final List<StopType> types;
  final List<Line> lines;

  factory Stop.fromJson(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'stop');
    return Stop(
      id: int.parse(json['id'] as String),
      name: json['name'] as String,
      coordinates: LatLng(
        lat: (json['location']['latitude'] as num).toDouble(),
        lng: (json['location']['longitude'] as num).toDouble(),
      ),
      types: [
        for (var productKey in json['products'].keys)
          if (json['products'][productKey]) _stopTypeFromString(productKey)
      ],
      lines: [for (var line in json['lines']) Line.fromJson(line)],
    );
  }
}

/// Types of transportation stops
enum StopType {
  suburban,
  subway,
  tram,
  bus,
  ferry,
  express,
  regional,
}

/// Converts string to enums
StopType _stopTypeFromString(String str) =>
    StopType.values.firstWhere((e) => e.toString() == 'StopType.$str');
