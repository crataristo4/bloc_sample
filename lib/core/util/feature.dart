/// File: feature.dart
/// Project: mobile
/// Created Date: Wednesday, May 26th 2021, 3:35:36 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 17th 2021 7:54:24 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:mobile/core/helpers/local.storage.dart';

class BaseFeature {
  final int backgroundColor;
  final int color;
  final String name;
  final String fullName;
  final String description;
  final String anim;
  final IconData icon;
  final MetricType type;

  const BaseFeature({
    required this.backgroundColor,
    required this.color,
    required this.name,
    required this.fullName,
    required this.description,
    required this.anim,
    required this.icon,
    required this.type,
  });

  static List<BaseFeature> get kFeatures => <BaseFeature>[
        BaseFeature(
          type: MetricType.bmi,
          backgroundColor: 0xff642B73,
          color: 0xffe0e0e0,
          description:
              'Body Mass Index (BMI) is a person’s weight in kilograms divided by the square of height in meters. A high BMI can be an indicator of high body fatness. BMI can be used to screen for weight categories that may lead to health problems but it is not diagnostic of the body fatness or health of an individual.',
          fullName: 'Body Mass Index',
          name: 'BMI',
          icon: Elusive.heart_circled,
          anim: '',
        ),
        BaseFeature(
          type: MetricType.bmr,
          backgroundColor: 0xffC6426E,
          color: 0xffe0e0e0,
          description:
              'Basal metabolic rate is the number of calories your body needs to accomplish its most basic (basal) life-sustaining functions.',
          fullName: 'Basal Metabolic Rate',
          name: 'BMR',
          icon: Elusive.heart,
          anim: '',
        ),
        BaseFeature(
          type: MetricType.waterIntake,
          backgroundColor: 0xffBD3F32,
          color: 0xffffffff,
          description:
              'Water is essential for the body to work properly. Daily water intake must be calculated according to the weight and lifestyle of each person as it is important that the body receives the right amount of fluids for his needs. This water calculator can help you estimate the amount of water you should drink as daily requirement.',
          fullName: 'Water Intake',
          name: 'Water Intake',
          icon: RpgAwesome.water_drop,
          anim: '',
        ),
        BaseFeature(
          type: MetricType.bodyFat,
          backgroundColor: 0xffFFAF7B,
          color: 0xff090909,
          description:
              'The body fat percentage (BFP) of a human or other living being is the total mass of fat divided by total body mass, multiplied by 100; body fat includes essential body fat and storage body fat. Essential is necessary to maintain life and reproductive functions.',
          fullName: 'Body Fat',
          name: 'Body Fat',
          icon: RpgAwesome.health,
          anim: '',
        ),
      ];
}
