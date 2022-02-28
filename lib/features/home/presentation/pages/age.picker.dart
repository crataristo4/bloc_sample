/// File: age.picker.dart
/// Project: mobile
/// Created Date: Friday, May 28th 2021, 5:02:40 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Friday, May 28th 2021 8:38:14 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

part of 'metric.reader.dart';

class AgePicker extends StatefulWidget {
  final Function(int) onAgeSelected;

  const AgePicker({Key? key, required this.onAgeSelected}) : super(key: key);

  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  var _currentAge = 16;

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'How old are you?'
            .h5(context, color: kColorScheme.secondary)
            .top(SizeConfig.kDeviceHeight * 0.12)
            .bottom(kSpacingX8),
        'To give you a better experience, we need to know your age'
            .bodyText1(
              context,
              color: kColorScheme.onBackground,
              alignment: TextAlign.center,
            )
            .bottom(kSpacingX40),
        Expanded(
          flex: 3,
          child: CarouselSlider(
            options: CarouselOptions(
                // height: kSpacingX120,
                initialPage: _currentAge,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (pageIndex, _) {
                  setState(() {
                    _currentAge = pageIndex;
                  });
                  widget.onAgeSelected(_currentAge);
                }),
            items: 0.to(80).map((i) {
              var active = _currentAge == i;
              return Builder(
                builder: (BuildContext context) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      color: active
                          ? kColorScheme.surface
                          : kColorScheme.background,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$_currentAge',
                      style: kTheme.textTheme.headline1?.copyWith(
                        color: active
                            ? kColorScheme.secondary
                            : kColorScheme.onBackground
                                .withOpacity(kEmphasisLow),
                      ),
                    ),
                  );
                },
              );
            }).toList(growable: false),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              '😊'.h4(context).bottom(kSpacingX8),
              Expanded(
                child:
                    'Swipe. left or right to select your age.\nYou were born in...'
                        .bodyText1(
                          context,
                          alignment: TextAlign.center,
                        )
                        .bottom(kSpacingX4),
              ),
              '${_getYearOfBirth()}'.h6(
                context,
                alignment: TextAlign.center,
                color: kColorScheme.secondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getYearOfBirth() => (DateTime.now().year - _currentAge).toString();
}
