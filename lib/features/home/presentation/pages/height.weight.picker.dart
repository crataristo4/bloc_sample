/// File: height.weight.picker.dart
/// Project: mobile
/// Created Date: Friday, May 28th 2021, 4:59:53 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Friday, May 28th 2021 8:55:36 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

part of 'metric.reader.dart';

class HeightWeightPicker extends StatefulWidget {
  // height , weight
  final Function(double, double) onSelected;
  final Gender gender;
  final double initialHeight;
  final double initialWeight;

  const HeightWeightPicker({
    Key? key,
    required this.onSelected,
    required this.gender,
    required this.initialHeight,
    required this.initialWeight,
  }) : super(key: key);
  @override
  _HeightWeightPickerState createState() => _HeightWeightPickerState();
}

class _HeightWeightPickerState extends State<HeightWeightPicker> {
  // UI state
  var _currentHeight = 0.0, _currentWeight = 20.0;
  var _currentImage = kFemaleHealthyImage;
  bool healthy = false,
      underweight = false,
      overweight = false,
      obese = false,
      isPounds = false,
      isFeet = false;
  var _weightMetrics = <String>['kg', 'lbs'],
      _heightMetrics = <String>['cm', 'ft'];
  var _activeHeight = 'cm', _activeWeight = 'kg';

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
  void initState() {
    super.initState();

    if (mounted) {
      _currentImage = widget.gender == Gender.female
          ? _femaleWeightImages[0]
          : _maleWeightImages[0];
      _currentHeight = widget.initialHeight;
      _currentWeight = widget.initialWeight;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    logger.d('height -> $_currentHeight & weight -> $_currentWeight');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'Tell us how tall you are & how much you weigh?'
            .h5(
              context,
              color: kColorScheme.secondary,
              alignment: TextAlign.center,
            )
            .top(SizeConfig.kDeviceHeight * 0.08)
            .bottom(kSpacingX8),
        'To give you a better experience, we need to know your age'
            .bodyText1(
              context,
              color: kColorScheme.onBackground,
              alignment: TextAlign.center,
            )
            .bottom(kSpacingX40),

        // content
        Expanded(
          child: Row(
            children: [
              // height
              Column(
                children: [
                  // slider
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: _sliderWithTheme(
                        context,
                        value: _currentHeight,
                        label: _currentHeight.toString(),
                        min: 0,
                        max: isFeet ? 10 : 300,
                        onChanged: (height) {
                          _currentHeight = height;

                          switch (widget.gender) {
                            case Gender.female:
                              break;
                            case Gender.male:
                              break;
                          }

                          setState(() {});
                          widget.onSelected(height, _currentWeight);
                        },
                      ),
                    ),
                  ),

                  // metric
                  '${isFeet ? roundDouble(_currentHeight, 1) : _currentHeight.toInt()} $_activeHeight'
                      .h6(context)
                      .bottom(kSpacingX8),

                  // title
                  'Height (in $_activeHeight)'.bodyText1(context),
                ],
              ),

              // image
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  child: _currentImage.asAssetImage(
                    width: SizeConfig.kDeviceWidth,
                    height: SizeConfig.kDeviceHeight * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // weight
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // slider
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: _sliderWithTheme(
                        context,
                        value: _currentWeight,
                        min: 0,
                        max: isPounds ? 400 : 200,
                        label: _currentWeight.toString(),
                        onChanged: _updateWeight,
                      ),
                    ),
                  ),

                  // metric
                  '${_currentWeight.toInt()} $_activeWeight'
                      .h6(context)
                      .bottom(kSpacingX8),

                  // title
                  'Weight (in $_activeWeight)'.bodyText1(context),
                ],
              ),
            ],
          ).bottom(kSpacingX20),
        ),

        Divider(),

        // height metric selector
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'Height format'.caption(context).bottom(kSpacingX6),
                  ToggleableButton(
                    active: _heightMetrics.indexOf(_activeHeight),
                    labels: _heightMetrics,
                    onToggle: (labelIndex) {
                      _activeHeight = _heightMetrics[labelIndex];
                      isFeet = _activeHeight == _heightMetrics[1];
                      _currentHeight = isFeet
                          ? _currentHeight.cmToFeet()
                          : _currentHeight.feetToCm();
                      setState(() {});
                    },
                  ),
                ],
              ).right(kSpacingX8),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'Weight format'.caption(context).bottom(kSpacingX6),
                  ToggleableButton(
                    active: _weightMetrics.indexOf(_activeWeight),
                    labels: _weightMetrics,
                    onToggle: (labelIndex) {
                      _activeWeight = _weightMetrics[labelIndex];
                      isPounds = _activeWeight == _weightMetrics[1];
                      _currentWeight = isPounds
                          ? _currentWeight.kgToPounds()
                          : _currentWeight.poundsToKg();
                      setState(() {});
                    },
                  ),
                ],
              ).left(kSpacingX8),
            ),
          ],
        ).top(kSpacingX8),
      ],
    );
  }

  /// update weight metrics
  void _updateWeight(weight) {
    _currentWeight = weight;

    try {
      var computedWeight =
          roundDouble(weight / (pow(_currentHeight.metresToCm(), 2)), 2);
      underweight = computedWeight < 18.5;
      healthy = computedWeight >= 18.5 && computedWeight <= 24.9;
      overweight = computedWeight >= 25.0 && computedWeight <= 29.9;
      obese = computedWeight > 30;

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

      setState(() {});
      widget.onSelected(_currentHeight, weight);
    } catch (e) {
      logger.e(e);
      context.showSnackBar('Update height first');
    }
  }
}
