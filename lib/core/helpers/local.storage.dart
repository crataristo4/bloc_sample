/// File: local.storage.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 10:17:18 am
/// Project: mobile
/// -----
/// Last Modified: Thursday, June 10th 2021 4:01:26 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/core/util/calculators.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_utils/shared_utils.dart';

part 'local.storage.g.dart';

// metric type
enum MetricType { bmi, bmr, bodyFat, waterIntake }

// metric reading
@JsonSerializable(fieldRename: FieldRename.snake)
class MetricReading {
  final MetricType type;
  final double reading;
  final String? desc;

  const MetricReading({
    required this.type,
    required this.reading,
    this.desc,
  });

  factory MetricReading.withDefaults(MetricType metricType) => MetricReading(
        reading: 0.0,
        type: metricType,
        desc: '',
      );

  factory MetricReading.fromJson(json) => _$MetricReadingFromJson(json);

  Map<String, dynamic> toJson() => _$MetricReadingToJson(this);

  @override
  String toString() => toJson().toString();
}

// metrics data model
@JsonSerializable(fieldRename: FieldRename.snake)
class Metric {
  final MetricReading bmi;
  final MetricReading bmr;
  final MetricReading bodyFat;
  final MetricReading waterIntake;
  final double weight;
  final double height;
  final double idealWeight;
  final double weightToLose;
  final int age;
  final String? bmiMessage;

  const Metric({
    required this.bmi,
    required this.bmr,
    required this.bodyFat,
    required this.waterIntake,
    required this.weight,
    required this.idealWeight,
    required this.height,
    required this.age,
    this.bmiMessage,
    this.weightToLose = 0,
  });

  factory Metric.withDefaults() => Metric(
        bmi: MetricReading.withDefaults(MetricType.bmi),
        bmr: MetricReading.withDefaults(MetricType.bmr),
        bodyFat: MetricReading.withDefaults(MetricType.bodyFat),
        waterIntake: MetricReading.withDefaults(MetricType.waterIntake),
        age: 16,
        height: 170,
        weight: 76,
        idealWeight: 0,
        weightToLose: 0,
        bmiMessage: 'Normal',
      );

  factory Metric.fromJson(json) => _$MetricFromJson(json);

  Map<String, dynamic> toJson() => _$MetricToJson(this);

  Metric copyWith({
    double? bmi,
    double? bmr,
    double? bodyFat,
    double? waterIntake,
    double? height,
    double? weight,
    double? weightToLose,
    double? idealWeight,
    int? age,
    String? bmiMessage,
  }) =>
      Metric(
        bmi: MetricReading(
          type: MetricType.bmi,
          reading: bmi ?? this.bmi.reading,
          desc: this.bmi.desc,
        ),
        bmr: MetricReading(
          type: MetricType.bmr,
          reading: bmr ?? this.bmr.reading,
          desc: this.bmr.desc,
        ),
        bodyFat: MetricReading(
          type: MetricType.bodyFat,
          reading: bodyFat ?? this.bodyFat.reading,
          desc: this.bodyFat.desc,
        ),
        waterIntake: MetricReading(
          type: MetricType.waterIntake,
          reading: waterIntake ?? this.waterIntake.reading,
          desc: this.waterIntake.desc,
        ),
        age: age ?? this.age,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        idealWeight: idealWeight ?? this.idealWeight,
        weightToLose: weightToLose ?? this.weightToLose,
        bmiMessage: bmiMessage,
      );

  @override
  String toString() => toJson().toString();
}

/// content model for local storage
class StorageContent {
  final String? username;
  final int themeMode;
  final Metric metric;

  const StorageContent({
    this.username,
    this.themeMode = 0,
    required this.metric,
  });

  factory StorageContent.useDefaults() => StorageContent(
        username: null,
        themeMode: ThemeMode.system.index,
        metric: Metric.withDefaults(),
      );

  StorageContent copyWith({
    String? username,
    ThemeMode? themeMode,
    Metric? metric,
  }) =>
      StorageContent(
        username: username ?? this.username,
        themeMode: themeMode?.index ?? this.themeMode,
        metric: metric ?? this.metric,
      );
}

abstract class BaseLocalStorage extends StateNotifier<StorageContent> {
  BaseLocalStorage() : super(StorageContent.useDefaults());

  String get username => state.username ?? '';

  Metric get metric => state.metric;

  ThemeMode get currentTheme => ThemeMode.values[state.themeMode];

  bool get loggedIn => !state.username.isNullOrEmpty();

  Stream get observeContent => stream;

  Future<void> updateUsername(String username);

  Future<void> updateTheme(ThemeMode themeMode);

  Future<void> updateMetric({
    double? bmi,
    double? bmr,
    double? bodyFat,
    double? waterIntake,
    double? height,
    double? weight,
    double? idealWeight,
    double? weightToLose,
    int? age,
    String? bmiMessage,
  });

  Future<void> logOut();
}

/// implementation of [BaseLocalStorage]
class LocalStorage extends BaseLocalStorage {
  final SharedPreferences prefs;

  LocalStorage({required this.prefs}) {
    // get values from shared preferences
    var name = prefs.getString(kUserKey) ?? username;
    var metricData = prefs.getString(kMetricKey) != null
        ? Metric.fromJson(jsonDecode(prefs.getString(kMetricKey)!) as Map)
        : metric;
    var theme = prefs.getInt(kThemeKey) ?? currentTheme.index;
    logger.i('user -> $name & themeMode -> $theme & metric -> $metric');

    // notify state
    state = StorageContent(
      username: name,
      themeMode: theme,
      metric: metricData,
    );
  }

  @override
  Future<void> updateTheme(ThemeMode themeMode) async {
    await prefs.setInt(kThemeKey, themeMode.index);
    state = state.copyWith(themeMode: themeMode);
  }

  @override
  Future<void> updateUsername(String username) async {
    await prefs.setString(kUserKey, username);
    state = state.copyWith(username: username);
  }

  @override
  Future<void> logOut() async {
    await prefs.clear();
    state = StorageContent.useDefaults();
  }

  @override
  Future<void> updateMetric({
    double? bmi,
    double? bmr,
    double? bodyFat,
    double? waterIntake,
    double? height,
    double? weight,
    double? idealWeight,
    double? weightToLose,
    int? age,
    String? bmiMessage,
  }) async {
    var updated = metric.copyWith(
      bmi: (bmi != null && bmi > 0) ? bmi : metric.bmi.reading,
      bmr: (bmr != null && bmr > 0) ? bmr : metric.bmr.reading,
      bodyFat:
          (bodyFat != null && bodyFat > 0) ? bodyFat : metric.bodyFat.reading,
      waterIntake: (waterIntake != null && waterIntake > 0)
          ? waterIntake
          : metric.waterIntake.reading,
      age: age == null ? 16 : age,
      weight: weight == null ? 0.0 : roundDouble(weight, 2),
      height: height == null ? 0.0 : roundDouble(height, 2),
      idealWeight: idealWeight,
      weightToLose: weightToLose,
      bmiMessage: bmiMessage,
    );
    var encoded = jsonEncode(updated.toJson());
    await prefs.setString(kMetricKey, encoded);
    state = state.copyWith(metric: updated);
  }
}
