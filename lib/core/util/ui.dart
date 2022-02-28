/// File: ui.dart
/// Project: mobile
/// Created Date: Wednesday, May 26th 2021, 6:01:26 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, May 27th 2021 10:11:47 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_utils/shared_utils.dart';

void kUseDefaultOverlays({
  bool isLightTheme = true,
  Color? navColor,
  Color? statusColor,
  Color? navIconColor,
  Brightness? statusIconBrightness,
}) =>
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme
          ? SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: navColor ?? kWhiteColor,
              systemNavigationBarDividerColor: navIconColor ?? kWhiteColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: statusIconBrightness ?? Brightness.dark,
              statusBarColor: statusColor ?? kWhiteColor,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: navColor ?? kBlackColor,
              systemNavigationBarDividerColor: navIconColor ?? kBlackColor,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: statusIconBrightness ?? Brightness.light,
              statusBarColor: statusColor ?? kBlackColor,
            ),
    );

// default orientation
void kUseDefaultOrientation() =>
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

// fonts
final _primaryFonts = GoogleFonts.workSans();
final _primaryTextTheme = GoogleFonts.workSansTextTheme().copyWith(
  headline4: _primaryFonts.copyWith(fontWeight: FontWeight.w600),
  headline5: _primaryFonts.copyWith(fontWeight: FontWeight.w600),
);

// theme
ThemeData useLightTheme(BuildContext context) =>
    kLightTheme(context: context).copyWith(
      textTheme: _primaryTextTheme,
      backgroundColor: Color(0xfff5f5f5),
      scaffoldBackgroundColor: Color(0xfff5f5f5),
      disabledColor: Color(0xffe0e0e0),
      colorScheme: kLightTheme(context: context).colorScheme.copyWith(
            background: Color(0xfff5f5f5),
          ),
    );
ThemeData useDarkTheme(BuildContext context) =>
    kDarkTheme(context: context).copyWith(
      textTheme: _primaryTextTheme,
      backgroundColor: Color(0xff141313),
      scaffoldBackgroundColor: Color(0xff141313),
      disabledColor: Color(0xff090909),
      colorScheme: kDarkTheme(context: context)
          .colorScheme
          .copyWith(background: Color(0xff141313), surface: Color(0xff212121)),
      // scaffoldBackgroundColor: Color(0xff141313),
    );
