/// File: calculator_test.dart
/// Project: mobile
/// Created Date: Tuesday, June 1st 2021, 2:43:56 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Project: mobile
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/util/calculators.dart';
import 'package:shared_utils/shared_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'calculator test',
    () async {
      var bmi = calculateBmi(
        gender: Gender.male,
        age: 26,
        weight: 80,
        height: 188,
      );
      var bmr = calculateBmr(
        gender: Gender.male,
        age: 26,
        weight: 80,
        height: 188,
      );
      var fat = calculateBodyFat(
        gender: Gender.male,
        age: 26,
        weight: 80,
        height: 188,
      );
      logger.d('bmi result -> $bmi');
      logger.d('bmr result -> $bmr');
      logger.d('fat result -> $fat');
    },
  );
}
