// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";

class BusAnimation extends StatefulWidget {
  BusAnimation({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BusAnimationState createState() => _BusAnimationState();
}

class _BusAnimationState extends State<BusAnimation> {
  String _animationName = 'driving';

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'assets/flare/train.flr',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: _animationName,
    );
  }
}
