/// File: home.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 5:32:01 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 1:11:25 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:mobile/core/di/injector.dart';
import 'package:mobile/core/helpers/local.storage.dart';
import 'package:mobile/core/routes/routes.gr.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:mobile/core/util/feature.dart';
import 'package:mobile/core/util/intents.dart';
import 'package:mobile/core/util/ui.dart';
import 'package:mobile/core/widgets/buttons.dart';
import 'package:mobile/features/home/domain/entities/featured.videos.dart';
import 'package:mobile/features/home/presentation/bloc/featured_video_cubit.dart';
import 'package:mobile/features/home/presentation/bloc/metric_cubit.dart';
import 'package:mobile/features/home/presentation/widgets/bottom.nav.dart';
import 'package:mobile/features/home/presentation/widgets/feature.tile.dart';
import 'package:mobile/features/home/presentation/widgets/featured.video.tile.dart';
import 'package:mobile/features/login/presentation/bloc/auth_cubit.dart';
import 'package:shared_utils/shared_utils.dart';

part 'dashboard.dart';

part 'help.desk.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // cubit
  final _authCubit = AuthCubit(localStorage: Injector.get());
  final _metricCubit = MetricCubit(localStorage: Injector.get());

  // UI state
  String username = '...';

  @override
  void dispose() {
    _authCubit.close();
    _metricCubit.close();
    super.dispose();
  }

  // bottom navigation configuration
  final List<BaseBottomBarItem> _bottomNavItems = <BaseBottomBarItem>[
    BaseBottomBarItem(
      icon: Iconic.home,
      label: 'Home',
      activeIcon: Iconic.home,
    ),
    BaseBottomBarItem(
      icon: Icons.help_outline_outlined,
      label: 'Help Desk',
      activeIcon: Icons.help_outlined,
    ),
  ];
  int _currentNav = 0;

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;
    var lightTheme = kTheme.brightness == Brightness.light;

    kUseDefaultOverlays(
      isLightTheme: lightTheme,
      statusColor: kColorScheme.background,
      statusIconBrightness: lightTheme ? Brightness.dark : Brightness.light,
      navColor: kColorScheme.surface,
      navIconColor: kColorScheme.surface,
    );

    return Material(
      color: kColorScheme.background,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            // header & body
            Positioned.fill(
              top: kSpacingX24,
              left: kSpacingX16,
              right: kSpacingX16,
              bottom: kSpacingX64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // greeting
                      BlocBuilder<AuthCubit, BlocState>(
                        bloc: _authCubit..getUser(),
                        builder: (context, state) {
                          if (state is SuccessState<String>) {
                            username = state.data;
                          }
                          return Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                'Hello,'
                                    .h6(context, alignment: TextAlign.start),
                                '$username.'.h4(
                                  context,
                                  alignment: TextAlign.start,
                                  color: kColorScheme.secondary,
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(FontAwesome5.facebook_f).clickable(
                              onTap: () => openUrl(kFacebookHandle),
                            ),
                            Icon(FontAwesome5.instagram).clickable(
                              onTap: () => openUrl(kInstagramHandle),
                            ),
                            Icon(FontAwesome5.youtube).clickable(
                              onTap: () => openUrl(kYoutubeHandle),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).bottom(kSpacingX8),

                  // notification
                  if (!_metricCubit.hasMetrics) ...{
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: kSpacingX6,
                        vertical: kSpacingX16,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: kSpacingX12,
                        horizontal: kSpacingX16,
                      ),
                      decoration: BoxDecoration(
                        color: kTheme.disabledColor,
                        borderRadius: BorderRadius.circular(kSpacingX8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Elusive.info_circled,
                            size: kSpacingX20,
                            color: kColorScheme.onBackground
                                .withOpacity(kEmphasisMedium),
                          ).right(kSpacingX12),
                          Expanded(
                            child:
                                'You haven\'t recorded any metrics lately. Tap on a tile to get started'
                                    .bodyText2(context),
                          ),
                        ],
                      ),
                    ),
                  },

                  // switch tabs
                  Expanded(child: _currentNav == 0 ? DashboardTab() : HelpDeskTab()),
                ],
              ),
            ),

            // bottom nav
            Positioned(
              left: kSpacingNone,
              right: kSpacingNone,
              bottom: kSpacingNone,
              height: kSpacingX64,
              child: BaseBottomNavigationBar(
                items: _bottomNavItems,
                currentNav: _currentNav,
                onSelected: (nav) {
                  setState(() {
                    _currentNav = _bottomNavItems.indexOf(nav);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
