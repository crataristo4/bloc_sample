/// File: injector.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 5:27:47 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, May 27th 2021 1:23:51 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/helpers/local.storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_utils/shared_utils.dart';

// shared preferences provider
final _sharedPrefsProvider =
    FutureProvider((_) async => await SharedPreferences.getInstance());

/// dependecy injection
class Injector {
  static final _deps = [];

  // register dependencies
  static Future<void> init() async {
    // dependency provider
    var container = ProviderContainer();

    // shared prefs
    var sharedPreferences = await container.read(_sharedPrefsProvider.future);

    // persistent storage
    BaseLocalStorage localStorage = LocalStorage(prefs: sharedPreferences);

    // add local storage
    _deps.add(localStorage);

    logger.i('registered ${_deps.length} dependencies');
  }

  // get dependency by type, or throw an Exception if otherwise
  static R get<R>() {
    for (var value in _deps) {
      if (value is R) return value;
    }
    throw Exception(
        'Could not find the requested dependency. Register it first');
  }
}
