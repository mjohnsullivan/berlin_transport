// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const berlinBrightYellow = Color(0xFFFFD300);
const berlinDarkYellow = Color(0xFFFFB900);

final appBarTheme = AppBarTheme(
  elevation: 0,
  color: berlinBrightYellow,
);

final appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: berlinBrightYellow,
  accentColor: berlinDarkYellow,
  appBarTheme: appBarTheme,

  // Define the default Font Family
  fontFamily: 'Montserrat',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    display1: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),

    //headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);
