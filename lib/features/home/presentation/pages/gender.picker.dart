/// File: gender.picker.dart
/// Project: mobile
/// Created Date: Friday, May 28th 2021, 2:21:01 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Tuesday, June 1st 2021 10:47:33 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

part of 'metric.reader.dart';

/// user's gender picker
class GenderPicker extends StatefulWidget {
  final Function(Gender) onGenderToggle;
  final Gender gender;

  const GenderPicker({
    Key? key,
    required this.onGenderToggle,
    required this.gender,
  }) : super(key: key);

  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  var _gender = Gender.female;
  final _sliderController = CarouselController();
  final _kUserGenderImages = <String>[kMaleImage, kFemaleImage];

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _gender = widget.gender;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'Choose your gender...'
            .h5(context, color: kColorScheme.secondary)
            .top(SizeConfig.kDeviceHeight * 0.12)
            .bottom(kSpacingX40),
        Expanded(
          child: CarouselSlider(
            carouselController: _sliderController,
            options: CarouselOptions(
              height: SizeConfig.kDeviceHeight * 0.4,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: Gender.values.indexOf(_gender),
              onPageChanged: (page, _) {
                setState(() => _gender = Gender.values[page]);
                widget.onGenderToggle(_gender);
              },
            ),
            items: _kUserGenderImages.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: SizeConfig.kDeviceWidth,
                    padding: EdgeInsets.symmetric(horizontal: kSpacingX24),
                    decoration: BoxDecoration(
                      color: kColorScheme.surface,
                      borderRadius: BorderRadius.circular(kSpacingX24),
                    ),
                    child: i.asAssetImage(
                      height: SizeConfig.kDeviceHeight * 0.4,
                      width: SizeConfig.kDeviceWidth,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        ToggleableButton(
          active: Gender.values.indexOf(_gender),
          onToggle: (current) {
            setState(() {
              _gender = Gender.values[current];
            });
            _sliderController.animateToPage(Gender.values.indexOf(_gender));
            widget.onGenderToggle(_gender);
          },
          labels: Gender.values.map((e) => e.asText()).toList(growable: false),
        ),
      ],
    ).centered();
  }
}
