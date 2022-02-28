/// File: help.desk.dart
/// Project: mobile
/// Created Date: Wednesday, May 26th 2021, 6:57:03 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Wednesday, June 2nd 2021 7:48:17 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

part of 'home.dart';

/// help desk UI
class HelpDeskTab extends StatefulWidget {
  @override
  _HelpDeskTabState createState() => _HelpDeskTabState();
}

class _HelpDeskTabState extends State<HelpDeskTab> {
  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;
    var kTextTheme = kTheme.textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: kSpacingX16,
        horizontal: kSpacingX16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text.rich(TextSpan(children: [
            TextSpan(
              text:
                  "Maintaining a healthy weight may reduce the risk of chronic diseases associated with overweight and obesity.\n\n",
              style: kTextTheme.bodyText2
                  ?.copyWith(color: kColorScheme.onBackground),
            ),
            TextSpan(
              text:
                  "Speak to BeaFit Natural Health Therapy to Lose, Gain or Maintain your weight. ",
              style: kTextTheme.bodyText2
                  ?.copyWith(color: kColorScheme.onBackground),
            ),
            TextSpan(
              text: "Sign up here",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  HapticFeedback.mediumImpact();
                  openUrl(kLinkToGoogleForm);
                },
              style: kTextTheme.overline?.copyWith(
                color: kColorScheme.secondary,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                fontWeight: FontWeight.bold,
                fontSize: kTextTheme.bodyText2?.fontSize,
              ),
            ),
            TextSpan(
              text:
                  "\n\nKeep track of your BMI (Body Mass Index) for a healthy life!",
              style: kTextTheme.bodyText2
                  ?.copyWith(color: kColorScheme.onBackground),
            ),
          ])),
          SizedBox(
            height: kSpacingX24,
          ),
          RoundedButton(
            label: "Learn more",
            onPressed: () => openUrl(kWebsiteUrl),
          ),


          // developer
          'Designed & developed by Quabynah Codelabs LLC (${DateTime.now().year})'
              .caption(context,
              weight: FontWeight.bold, alignment: TextAlign.center, emphasis: kEmphasisLow)
              .vertical(kSpacingX24),
        ],
      ),
    );
  }
}
