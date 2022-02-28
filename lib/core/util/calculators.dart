/// File: calculators.dart
/// Project: mobile
/// Created Date: Wednesday, May 26th 2021, 7:59:59 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 4:09:17 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'calculators.g.dart';

/// gender
enum Gender { male, female }

// metric for bmi
enum BmiMetric { underweight, normal, overweight, obese }

// result for bmi reading
@JsonSerializable(fieldRename: FieldRename.snake)
class BmiMetricResult {
  final double idealWeight;
  final double reading;
  final double weightToLose;
  final String metric;
  final String message;

  const BmiMetricResult({
    required this.idealWeight,
    required this.reading,
    required this.metric,
    required this.message,
    this.weightToLose = 0,
  });

  Map<String, dynamic> toJson() => _$BmiMetricResultToJson(this);

  @override
  String toString() => toJson().toString();
}

// bmi
BmiMetricResult calculateBmi({
  required Gender gender,
  required int age,
  required double weight,
  required double height,
  bool inMetres = true,
  bool inPounds = false,
}) {
  if (!inMetres) height = height.feetToCm();
  if (inPounds) weight.poundsToKg();
  var message = '', metric = '';
  var isMale = gender == Gender.male;

  // compute ideal weight
  var idealWeight = roundDouble((isMale ? 50 : 45.5) + 0.9 * (height - 152), 2);
  var weightToLose = roundDouble(idealWeight - weight, 2);
  var result = roundDouble(weight / (pow(height, 2)) * 10000, 2);

  switch (gender) {
    case Gender.male:
      if (result < 18.5) {
        metric = BmiMetric.underweight.asText();
      } else if (result >= 18.5 && result <= 24.9) {
        metric = BmiMetric.normal.asText();
      } else if (result >= 25.0 && result <= 29.9) {
        metric = BmiMetric.overweight.asText();
      } else {
        metric = BmiMetric.obese.asText();
      }
      return BmiMetricResult(
        idealWeight: idealWeight,
        reading: result,
        metric: metric,
        message: message,
        weightToLose: weightToLose,
      );
    case Gender.female:
      if (result < 18.5) {
        metric = BmiMetric.underweight.asText();
      } else if (result >= 18.5 && result <= 24.9) {
        metric = BmiMetric.normal.asText();
      } else if (result >= 25.0 && result <= 29.9) {
        metric = BmiMetric.overweight.asText();
      } else {
        metric = BmiMetric.obese.asText();
      }
      return BmiMetricResult(
        idealWeight: idealWeight,
        reading: result,
        metric: metric,
        message: message,
        weightToLose: weightToLose,
      );
  }
}

// bmr
double calculateBmr({
  required Gender gender,
  required int age,
  required double weight,
  required double height,
  bool inMetres = true,
  bool inPounds = true,
}) {
  if (!inMetres) height = height.feetToCm();
  if (inPounds) weight.poundsToKg();
  switch (gender) {
    case Gender.male:
      return roundDouble(66 + (weight * 13.7) + (5 * height) - (6.8 * age), 2);
    case Gender.female:
      return roundDouble(
          655 + (weight * 9.6) + (1.8 * height) - (4.7 * age), 2);
  }
}

// body fat
double calculateBodyFat({
  required Gender gender,
  required int age,
  required double weight,
  required double height,
  bool inMetres = true,
  bool inPounds = true,
}) {
  if (!inMetres) height = height.feetToCm();
  if (inPounds) weight.poundsToKg();
  switch (gender) {
    case Gender.male:
      var fat = 11 + (weight - (height - 100));
      return (roundDouble(fat, 2)).inPercentage();
    case Gender.female:
      var fat = 22 + (weight - (height - 100));
      return (roundDouble(fat, 2)).inPercentage();
  }
}

// water intake
double calculateWaterIntake({
  required Gender gender,
  required int age,
}) {
  switch (gender) {
    case Gender.male:
      if (age.inRange(19, 100)) {
        return 3.7;
      }
      if (age.inRange(14, 18)) {
        return 3.3;
      }
      if (age.inRange(9, 13)) {
        return 2.4;
      }
      if (age.inRange(4, 8)) {
        return 2.4;
      }
      if (age.inRange(0, 3)) {
        return 1.3;
      }
      return 0.0;
    case Gender.female:
      if (age.inRange(19, 100)) {
        return 2.7;
      }
      if (age.inRange(14, 18)) {
        return 2.3;
      }
      if (age.inRange(9, 13)) {
        return 2.1;
      }
      if (age.inRange(4, 8)) {
        return 1.7;
      }
      if (age.inRange(0, 3)) {
        return 1.3;
      }
      return 0.0;
  }
}

/// extensions on [int]
extension IntX on int {
  bool inRange(int min, int max) => this >= min && this <= max;

  List<int> to(max) {
    var result = <int>[];
    for (var i = 0; i < max; i++) {
      result.add(i);
    }
    return result;
  }
}

/// extensions on [double]
extension DoubleX on double {
  double inPercentage() => this;

  double feetToCm() => roundDouble((this * 30.48), 4);

  double cmToFeet() => roundDouble((this * 0.0328084), 4);

  double metresToCm() => this * 0.01;

  double poundsToKg() => roundDouble(this * 0.453592, 4);

  double kgToPounds() => roundDouble(this * 2.20462, 4);
}

extension BmiMetricX on BmiMetric {
  String asText() => this
      .toString()
      .replaceAll('BmiMetric', '')
      .replaceAll('.', '')
      .toUpperCase();

  BmiMetric fromText(String text) {
    if (text == 'Obese'.toUpperCase()) {
      return BmiMetric.obese;
    } else if (text == 'Underweight'.toUpperCase()) {
      return BmiMetric.underweight;
    } else if (text == 'Overweight'.toUpperCase()) {
      return BmiMetric.overweight;
    } else {
      return BmiMetric.normal;
    }
  }
}

extension GenderX on Gender {
  String asText() => this
      .toString()
      .replaceAll('Gender', '')
      .replaceAll('.', '')
      .toUpperCase();
}

/// round [value] to decimal [places]
double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
