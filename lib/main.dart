/// File: main.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 4:21:02 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Tuesday, May 25th 2021 5:46:39 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/app.dart';
import 'package:mobile/core/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // register dependencies
  await Injector.init();

  runApp(ProviderScope(child: CoreBmrApp()));
}
