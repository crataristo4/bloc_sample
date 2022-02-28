// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculators.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BmiMetricResult _$BmiMetricResultFromJson(Map<String, dynamic> json) {
  return BmiMetricResult(
    idealWeight: (json['ideal_weight'] as num).toDouble(),
    reading: (json['reading'] as num).toDouble(),
    metric: json['metric'] as String,
    message: json['message'] as String,
    weightToLose: (json['weight_to_lose'] as num).toDouble(),
  );
}

Map<String, dynamic> _$BmiMetricResultToJson(BmiMetricResult instance) =>
    <String, dynamic>{
      'ideal_weight': instance.idealWeight,
      'reading': instance.reading,
      'weight_to_lose': instance.weightToLose,
      'metric': instance.metric,
      'message': instance.message,
    };
