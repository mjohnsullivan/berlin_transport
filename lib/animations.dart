// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'dart:math' show Random;

/// Types of transport animations
enum TransportAnimationType {
  bus,
  train,
  metro,
}

/// Shows a specified transport animation
class TransportAnimation extends StatefulWidget {
  TransportAnimation({Key key, @required this.type}) : super(key: key);
  final TransportAnimationType type;

  @override
  createState() => _TransportAnimationState();
}

class _TransportAnimationState extends State<TransportAnimation> {
  static const _animationName = 'driving';

  String _animationAssetPath(TransportAnimationType type) {
    switch (type) {
      case TransportAnimationType.bus:
        return 'assets/flare/bus.flr';
      case TransportAnimationType.metro:
        return 'assets/flare/metro.flr';
      default:
        return 'assets/flare/train.flr';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      _animationAssetPath(widget.type),
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: _animationName,
    );
  }
}

TransportAnimationType randomTransportAnimationType() {
  final random = Random();
  switch (random.nextInt(3)) {
    case 0:
      return TransportAnimationType.bus;
    case 1:
      return TransportAnimationType.metro;
    default:
      return TransportAnimationType.train;
  }
}
