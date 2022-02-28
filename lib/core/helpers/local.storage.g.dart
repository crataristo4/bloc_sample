// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local.storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetricReading _$MetricReadingFromJson(Map<String, dynamic> json) {
  return MetricReading(
    type: _$enumDecode(_$MetricTypeEnumMap, json['type']),
    reading: (json['reading'] as num).toDouble(),
    desc: json['desc'] as String?,
  );
}

Map<String, dynamic> _$MetricReadingToJson(MetricReading instance) =>
    <String, dynamic>{
      'type': _$MetricTypeEnumMap[instance.type],
      'reading': instance.reading,
      'desc': instance.desc,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MetricTypeEnumMap = {
  MetricType.bmi: 'bmi',
  MetricType.bmr: 'bmr',
  MetricType.bodyFat: 'bodyFat',
  MetricType.waterIntake: 'waterIntake',
};

Metric _$MetricFromJson(Map<String, dynamic> json) {
  return Metric(
    bmi: MetricReading.fromJson(json['bmi']),
    bmr: MetricReading.fromJson(json['bmr']),
    bodyFat: MetricReading.fromJson(json['body_fat']),
    waterIntake: MetricReading.fromJson(json['water_intake']),
    weight: (json['weight'] as num).toDouble(),
    idealWeight: (json['ideal_weight'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
    age: json['age'] as int,
    bmiMessage: json['bmi_message'] as String?,
    weightToLose: (json['weight_to_lose'] as num).toDouble(),
  );
}

Map<String, dynamic> _$MetricToJson(Metric instance) => <String, dynamic>{
      'bmi': instance.bmi,
      'bmr': instance.bmr,
      'body_fat': instance.bodyFat,
      'water_intake': instance.waterIntake,
      'weight': instance.weight,
      'height': instance.height,
      'ideal_weight': instance.idealWeight,
      'weight_to_lose': instance.weightToLose,
      'age': instance.age,
      'bmi_message': instance.bmiMessage,
    };
