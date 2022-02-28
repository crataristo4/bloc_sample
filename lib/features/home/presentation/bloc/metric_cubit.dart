/// File: metric_cubit.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 6:08:04 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 4:02:16 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:bloc/bloc.dart';
import 'package:mobile/core/helpers/local.storage.dart';
import 'package:mobile/core/util/calculators.dart';
import 'package:shared_utils/shared_utils.dart';

class MetricCubit extends Cubit<BlocState> {
  final BaseLocalStorage localStorage;
  MetricCubit({required this.localStorage}) : super(BlocState.initialState());

  bool get hasMetrics => localStorage.metric.bmi.reading > 0;

  Future<void> computeMetrics({
    required Gender gender,
    required int age,
    required double weight,
    required double height,
    bool inMetres = true,
    bool inPounds = false,
  }) async {
    emit(BlocState.loadingState());
    logger.i('metrics -> $gender $age $weight $height');

    var bmiResult = calculateBmi(
      gender: gender,
      age: age,
      weight: weight,
      height: height,
    );
    var bmrResult = calculateBmr(
      gender: gender,
      age: age,
      weight: weight,
      height: height,
    );
    var bodyFat = calculateBodyFat(
      gender: gender,
      age: age,
      weight: weight,
      height: height,
    );
    var waterIntake = calculateWaterIntake(gender: gender, age: age);

    await localStorage.updateMetric(
      bmi: bmiResult.reading,
      bmr: bmrResult,
      bodyFat: bodyFat,
      waterIntake: waterIntake,
      weight: weight,
      height: height,
      idealWeight: bmiResult.idealWeight,
      weightToLose: bmiResult.weightToLose,
      age: age,
      bmiMessage: bmiResult.metric,
    );

    emit(BlocState<Metric>.successState(data: localStorage.metric));
  }

  Future<void> getLastMetrics() async {
    emit(BlocState.loadingState());
    // get last saved metrics
    var metric = localStorage.metric;
    emit(BlocState<Metric>.successState(data: metric));
  }
}
