/// File: metric.reader.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 1:26:36 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 5:20:59 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/di/injector.dart';
import 'package:mobile/core/helpers/local.storage.dart';
import 'package:mobile/core/routes/routes.gr.dart';
import 'package:mobile/core/util/calculators.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:mobile/core/util/ui.dart';
import 'package:mobile/core/widgets/buttons.dart';
import 'package:mobile/features/home/presentation/bloc/metric_cubit.dart';
import 'package:mobile/features/home/presentation/widgets/toggleable.button.dart';
import 'package:shared_utils/shared_utils.dart';
import 'package:auto_route/auto_route.dart';

part 'gender.picker.dart';
part 'age.picker.dart';
part 'height.weight.picker.dart';

class MetricReaderPage extends StatefulWidget {
  @override
  _MetricReaderPageState createState() => _MetricReaderPageState();
}

class _MetricReaderPageState extends State<MetricReaderPage> {
  // cubit
  final _metricCubit = MetricCubit(localStorage: Injector.get());

  // UI state
  Gender gender = Gender.male;
  double height = 0, weight = 0;
  int age = 16;
  bool _loading = false;
  int _currentNav = 0, _pages = 3;
  final _pageController = PageController();

  @override
  void dispose() {
    _metricCubit.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;
    var lightTheme = kTheme.brightness == Brightness.light;

    kUseDefaultOverlays(
      statusColor: kColorScheme.background,
      statusIconBrightness: lightTheme ? Brightness.dark : Brightness.light,
      navColor: kColorScheme.background,
      navIconColor: kColorScheme.background,
    );

    return BlocListener<MetricCubit, BlocState>(
      bloc: _metricCubit,
      listener: (context, state) {
        _loading = state is LoadingState;
        if (mounted) setState(() {});

        if (state is SuccessState<Metric>) {
          context.router.popAndPush(MetricResultRoute(gender: gender));
        }

        if (state is ErrorState) {
          context.showSnackBar(state.failure.toString());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // pages
              Positioned.fill(
                left: kSpacingX24,
                right: kSpacingX24,
                bottom: kSpacingX32,
                child: _loading
                    ? CircularProgressIndicator.adaptive().centered()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (page) {
                                _currentNav = page;
                                setState(() {});
                              },
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return GenderPicker(
                                      gender: gender,
                                      onGenderToggle: (selected) {
                                        setState(() {
                                          gender = selected;
                                        });
                                      },
                                    );
                                  case 1:
                                    return HeightWeightPicker(
                                      gender: gender,
                                      initialHeight: height,
                                      initialWeight: weight,
                                      onSelected: (height, weight) {
                                        setState(() {
                                          this.height = height;
                                          this.weight = weight;
                                        });
                                      },
                                    );
                                  default:
                                    return AgePicker(
                                      onAgeSelected: (age) {
                                        setState(() {
                                          this.age = age;
                                        });
                                      },
                                    );
                                }
                              },
                              itemCount: _pages,
                            ),
                          ),
                          RoundedButton(
                            label: (_currentNav == _pages - 1)
                                ? 'Calculate'
                                : 'Next',
                            onPressed: () {
                              if (_currentNav == _pages - 1) {
                                // perform computations
                                _metricCubit.computeMetrics(
                                  gender: gender,
                                  age: age,
                                  weight: weight,
                                  height: height,
                                );
                              } else {
                                _pageController.animateToPage(
                                  ++_currentNav,
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ).top(kSpacingX48),
                        ],
                      ),
              ),

              // navigation
              Positioned(
                top: kSpacingX16,
                left: kSpacingX24,
                child: AnimatedOpacity(
                  opacity: (_currentNav == 0) ? 0 : 1,
                  duration: Duration(milliseconds: 400),
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
                  ).clickable(
                    onTap: () => _pageController.animateToPage(
                      --_currentNav,
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _sliderWithTheme(
  BuildContext context, {
  double min = 0.0,
  double max = 100.0,
  String label = '',
  double value = 0.0,
  onChanged,
}) =>
    SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Theme.of(context).colorScheme.secondary,
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: kSpacingX8,
        thumbColor: Theme.of(context).colorScheme.secondary,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: kSpacingX12),
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: kSpacingX28),
      ),
      child: Slider.adaptive(
        min: min,
        max: max,
        value: value,
        onChanged: onChanged,
        label: label,
      ),
    );
