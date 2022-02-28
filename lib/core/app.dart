/// File: app.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 5:33:45 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, May 27th 2021 1:25:44 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/di/injector.dart';
import 'package:mobile/core/routes/routes.gr.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:mobile/core/util/ui.dart';
import 'package:mobile/features/theme/theme_cubit.dart';
import 'package:shared_utils/shared_utils.dart';

/// router instance
final _appRouter = AppRouter();

/// application instance
class CoreBmrApp extends StatefulWidget {
  @override
  _CoreBmrAppState createState() => _CoreBmrAppState();
}

class _CoreBmrAppState extends State<CoreBmrApp> {
  final _themeCubit = ThemeCubit(localStorage: Injector.get());
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    kUseDefaultOrientation();
  }

  @override
  void dispose() {
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, BlocState>(
      bloc: _themeCubit..getCurrentTheme(),
      builder: (context, state) {
        if (state is SuccessState<ThemeMode>) {
          _themeMode = state.data;
        }
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate(),
          title: kAppName,
          theme: useLightTheme(context),
          darkTheme: useDarkTheme(context),
          themeMode: _themeMode,
          scrollBehavior: CupertinoScrollBehavior(),
        );
      },
    );
  }
}
