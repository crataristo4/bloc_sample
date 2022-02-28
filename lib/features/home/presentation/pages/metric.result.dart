/// File: metric.result.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 1:27:48 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 5:33:53 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mobile/core/di/injector.dart';
import 'package:mobile/core/helpers/local.storage.dart';
import 'package:mobile/core/util/calculators.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:mobile/core/util/feature.dart';
import 'package:mobile/core/util/ui.dart';
import 'package:mobile/features/home/presentation/bloc/metric_cubit.dart';
import 'package:mobile/features/home/presentation/widgets/feature.tile.dart';
import 'package:shared_utils/shared_utils.dart';

class MetricResultPage extends StatefulWidget {
  final Gender gender;

  const MetricResultPage({Key? key, required this.gender}) : super(key: key);

  @override
  _MetricResultPageState createState() => _MetricResultPageState();
}

class _MetricResultPageState extends State<MetricResultPage> {
  final _metricCubit = MetricCubit(localStorage: Injector.get());
  Metric? metricResult;

  // UI
  late ColorScheme kColorScheme;
  bool healthy = false, underweight = false, overweight = false, obese = false;
  var _currentImage = kFemaleHealthyImage;
  final _maleWeightImages = <String>[
    kMaleHealthyImage,
    kMaleUnderweightImage,
    kMaleOverweightImage,
    kMaleObeseImage,
  ];
  final _femaleWeightImages = <String>[
    kFemaleHealthyImage,
    kFemaleUnderweightImage,
    kFemaleOverweightImage,
    kFemaleObeseImage,
  ];

  @override
  void dispose() {
    _metricCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _metricCubit.getLastMetrics();
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    kColorScheme = kTheme.colorScheme;

    var lightTheme = kTheme.brightness == Brightness.light;

    kUseDefaultOverlays(
      statusColor: kColorScheme.background,
      statusIconBrightness: lightTheme ? Brightness.dark : Brightness.light,
      navColor: kColorScheme.background,
      navIconColor: kColorScheme.background,
    );

    return BlocBuilder<MetricCubit, BlocState>(
      bloc: _metricCubit,
      builder: (context, state) {
        var range = 0.0;

        // success branch
        if (state is SuccessState<Metric>) {
          logger.i('data -> ${state.data}');
          metricResult = state.data;
          if (metricResult != null) {
            // update
            underweight = metricResult!.bmi.reading < 18.5;
            healthy = metricResult!.bmi.reading >= 18.5 &&
                metricResult!.bmi.reading <= 24.9;
            overweight = metricResult!.bmi.reading >= 25.0 &&
                metricResult!.bmi.reading <= 29.9;
            obese = metricResult!.bmi.reading > 30;

            // range of indicator
            if (healthy) range = 0.4;
            if (underweight) range = 0.1;
            if (overweight) range = 0.55;
            if (obese) range = 0.68;

            // image
            switch (widget.gender) {
              case Gender.female:
                if (healthy) _currentImage = _femaleWeightImages[0];
                if (underweight) _currentImage = _femaleWeightImages[1];
                if (overweight) _currentImage = _femaleWeightImages[2];
                if (obese) _currentImage = _femaleWeightImages[3];
                break;
              case Gender.male:
                if (healthy) _currentImage = _maleWeightImages[0];
                if (underweight) _currentImage = _maleWeightImages[1];
                if (overweight) _currentImage = _maleWeightImages[2];
                if (obese) _currentImage = _maleWeightImages[3];
                break;
            }
          }
        }

        return Scaffold(
          body: metricResult == null
              ? CircularProgressIndicator.adaptive().centered()
              : SafeArea(
                  child: Stack(
                    children: [
                      // image
                      Positioned(
                        top: kSpacingX28,
                        left: kSpacingNone,
                        right: kSpacingNone,
                        child: _currentImage.asAssetImage(
                          width: SizeConfig.kDeviceWidth,
                          height: SizeConfig.kDeviceHeight * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // page content
                      Positioned.fill(
                        top: SizeConfig.kDeviceHeight * 0.25,
                        left: kSpacingX24,
                        right: kSpacingX24,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // BMI container
                              Container(
                                width: SizeConfig.kDeviceWidth,
                                padding: EdgeInsets.symmetric(
                                  horizontal: kSpacingX24,
                                  vertical: kSpacingX20,
                                ),
                                decoration: BoxDecoration(
                                  color: kColorScheme.surface,
                                  borderRadius:
                                      BorderRadius.circular(kSpacingX20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // bmi reading
                                    Text(
                                      '${metricResult!.bmi.reading}',
                                      style:
                                          kTheme.textTheme.headline2?.copyWith(
                                        color: kColorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // reader
                                    SizedBox(
                                      height: kSpacingX40,
                                      child: Stack(
                                        children: [
                                          // metric reading bar
                                          Positioned.fill(
                                            left: kSpacingNone,
                                            right: kSpacingNone,
                                            child: Container(
                                              width: SizeConfig.kDeviceWidth,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: kSpacingX24,
                                                vertical: kSpacingX20,
                                              ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xffE1E950),
                                                    Color(0xffADE370),
                                                    Color(0xff8DE184),
                                                    Color(0xff7BDE92),
                                                    Color(0xff53D8AF),
                                                    Color(0xff34D4C3),
                                                    Color(0xff21D2D6),
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  // stops: [0.2, 0.4, 0.6, 0.7, 1.0],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kSpacingX20),
                                              ),
                                            ),
                                          ),

                                          // reader metre
                                          Positioned(
                                            top: kSpacingNone,
                                            bottom: kSpacingNone,
                                            left:
                                                SizeConfig.kDeviceWidth * range,
                                            child: Container(
                                              width: kSpacingX8,
                                              decoration: BoxDecoration(
                                                color: kColorScheme.onBackground
                                                    .withOpacity(kEmphasisLow),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // bmi message
                                    '${metricResult!.bmiMessage}'
                                        .bodyText1(context,
                                            color: kColorScheme.primary)
                                        .vertical(kSpacingX6),

                                    // height, weight & age
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // age
                                        _buildUserMetadata(
                                          title: '${metricResult!.age}',
                                          desc: 'Age',
                                        ),
                                        _buildUserMetadata(
                                          title: '${metricResult!.height}',
                                          desc: 'Height',
                                        ),
                                        _buildUserMetadata(
                                          title: '${metricResult!.weight}',
                                          desc: 'Weight',
                                        ),
                                      ],
                                    ).horizontal(kSpacingX12).top(kSpacingX16),

                                    // ideal weight & weight to lose
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: _buildUserMetadata(
                                            title: '${metricResult!.idealWeight}',
                                            desc: 'Ideal weight',
                                          ).right(kSpacingX8),
                                        ),
                                        Expanded(
                                          child: _buildUserMetadata(
                                            title: '${metricResult!.weightToLose}',
                                            desc: 'Weight to lose',
                                          ).left(kSpacingX8),
                                        ),
                                      ],
                                    ).top(kSpacingX16),
                                  ],
                                ),
                              ),

                              // feature tiles
                              BlocBuilder<MetricCubit, BlocState>(
                                bloc: _metricCubit,
                                builder: (context, state) => SizedBox(
                                  width: SizeConfig.kDeviceWidth,
                                  height: SizeConfig.kDeviceHeight * 0.35,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: kSpacingX12,
                                      mainAxisSpacing: kSpacingX12,
                                      childAspectRatio: 4 / 3,
                                    ),
                                    itemBuilder: (context, index) {
                                      var feature =
                                          BaseFeature.kFeatures[index];
                                      var stats = '';
                                      var statsDesc = 'Tap for more details';
                                      if (state is SuccessState<Metric>) {
                                        var metric = state.data;
                                        if (feature.type == metric.bmi.type) {
                                          if (metric.bmi.reading > 0) {
                                            stats =
                                                metric.bmi.reading.toString();
                                            statsDesc = feature.fullName;
                                          }
                                        }

                                        if (feature.type == metric.bmr.type) {
                                          if (metric.bmr.reading > 0) {
                                            stats =
                                                metric.bmr.reading.toString();
                                            statsDesc = feature.fullName;
                                          }
                                        }

                                        if (feature.type ==
                                            metric.waterIntake.type) {
                                          if (metric.waterIntake.reading > 0) {
                                            stats = metric.waterIntake.reading
                                                .toString();
                                            statsDesc = 'litres per day';
                                          }
                                        }

                                        if (feature.type ==
                                            metric.bodyFat.type) {
                                          stats =
                                              metric.bodyFat.reading.toString();
                                          statsDesc = 'calories needed';
                                        }
                                      }
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        delay: Duration(milliseconds: 150),
                                        child: SlideAnimation(
                                          child: FadeInAnimation(
                                            child: FeatureTile(
                                              feature: feature,
                                              stats: stats,
                                              statsDesc: statsDesc,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: BaseFeature.kFeatures.length,
                                  ),
                                ),
                              ).top(kSpacingX24),
                            ],
                          ),
                        ),
                      ),

                      // back button
                      Positioned(
                        top: kSpacingX16,
                        left: kSpacingX24,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.keyboard_backspace_outlined,
                              color: kColorScheme.secondary,
                            ).right(kSpacingX8),
                            'Go back'.bodyText1(
                              context,
                              color: kColorScheme.secondary,
                            ),
                          ],
                        ).clickable(onTap: () => context.router.pop()),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildUserMetadata({required String title, required String desc}) =>
      Container(
        padding: EdgeInsets.all(kSpacingX12),
        decoration: BoxDecoration(
          color: kColorScheme.background,
          borderRadius: BorderRadius.circular(kSpacingX8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title.h4(
              context,
              color: kColorScheme.secondary,
            ),
            desc.caption(
              context,
              color: kColorScheme.onBackground,
              emphasis: kEmphasisMedium,
            ),
          ],
        ),
      );
}
