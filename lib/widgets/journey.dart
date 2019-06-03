// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:berlin_transport/theme.dart';
import 'package:berlin_transport/widgets/widgets.dart';
import 'package:berlin_transport/data/data.dart' as data;
import 'package:berlin_transport/utils.dart';

class Journey extends StatelessWidget {
  Journey(this.journey);
  final data.Journey journey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        color: berlinBrightYellow,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ...[for (var leg in journey.legs) Leg(leg)],
              PlaceName(journey.legs.last.destination.name),
            ],
          ),
        ),
      ),
    );
  }
}

class Leg extends StatelessWidget {
  Leg(this.leg);
  final data.Leg leg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlaceName('${leg.origin.name}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${prettyTime(leg.departureTime)}'),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ModeIcon(leg.line?.mode), //TransportIcon(leg.line?.type),
            ),
            Text('${prettyTime(leg.arrivalTime)}'),
          ],
        ),
      ],
    );
  }
}

class PlaceName extends StatelessWidget {
  const PlaceName(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}
