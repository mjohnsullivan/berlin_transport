/// Data models

class LatLng {
  const LatLng({this.lat, this.lng});
  final double lat;
  final double lng;
}

class Location {
  Location({this.id, this.name, this.coordinates});
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

final jsonStuff = '''
{
        "type": "stop",
        "id": "900000311315",
        "name": "Eisenhüttenstadt, City Center",
        "location": {
            "type": "location",
            "latitude": 52.151189,
            "longitude": 14.634906
        },
        "products": {
            "suburban": false,
            "subway": false,
            "tram": false,
            "bus": true,
            "ferry": false,
            "express": false,
            "regional": false
        },
''';
