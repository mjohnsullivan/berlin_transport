// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';

String prettyTime(DateTime time) => DateFormat('HH:mm').format(time);
String prettyDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
