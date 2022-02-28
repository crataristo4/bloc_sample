/// File: welcome.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 5:23:19 pm
/// Project: mobile
/// -----
/// Last Modified: Friday, June 11th 2021 8:46:13 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/di/injector.dart';
import 'package:mobile/core/routes/routes.gr.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:mobile/core/util/ui.dart';
import 'package:mobile/core/widgets/buttons.dart';
import 'package:mobile/features/login/presentation/bloc/auth_cubit.dart';
import 'package:shared_utils/shared_utils.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // cubit
  final _authCubit = AuthCubit(localStorage: Injector.get());

  // UI state
  bool _loggedIn = false;

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeSharedUtils(context);
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    kUseDefaultOverlays(
      isLightTheme: kTheme.brightness == Brightness.light,
      statusColor: kTransparent,
      navColor: kColorScheme.surface,
      navIconColor: kColorScheme.surface,
      statusIconBrightness: Brightness.light,
    );

    return Scaffold(
      body: Stack(
        children: [
          // background image
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kWelcomeImages[Random().nextInt(1)]),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black45, BlendMode.darken),
                ),
              ),
            ),
          ),

          // content
          Positioned(
            bottom: kSpacingNone,
            left: kSpacingNone,
            right: kSpacingNone,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: kSpacingX28,
                vertical: kSpacingX24,
              ),
              decoration: BoxDecoration(
                color: kColorScheme.background.withOpacity(kEmphasisHigh),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kSpacingX24),
                  topRight: Radius.circular(kSpacingX24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kAppName.h4(context).bottom(kSpacingX4),
                  kAppNameSub
                      .h6(context, emphasis: kEmphasisMedium)
                      .bottom(kSpacingX12),
                  kAppDesc.bodyText1(context).bottom(kSpacingX36),
                  BlocBuilder<AuthCubit, BlocState>(
                    bloc: _authCubit..getLoginState(),
                    builder: (context, state) {
                      if (state is SuccessState<bool>) {
                        _loggedIn = state.data;
                      }
                      return RoundedButton(
                        label: _loggedIn ? 'Get started' : 'Next',
                        onPressed: () => context.router.pushAndPopUntil(
                            _loggedIn ? HomeRoute() : LoginRoute(),
                            predicate: (_) => false),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
