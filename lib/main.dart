import 'package:flutter/material.dart';

import 'package:berlin_transport/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berlin Transport Demo',
      home: BerlinTransportPage(),
    );
  }
}

class BerlinTransportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Berlin Transport Demo'));
  }
}
