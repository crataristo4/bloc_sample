/// File: bottom.nav.dart
/// Project: mobile
/// Created Date: Wednesday, May 26th 2021, 3:59:49 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 2:40:48 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:mobile/core/routes/routes.gr.dart';
import 'package:shared_utils/shared_utils.dart';
import 'package:auto_route/auto_route.dart';

class BaseBottomBarItem {
  final IconData icon;
  final String label;
  final IconData activeIcon;

  const BaseBottomBarItem({
    required this.icon,
    required this.label,
    required this.activeIcon,
  });
}

class BaseBottomNavigationBar extends StatelessWidget {
  final List<BaseBottomBarItem> items;
  final int currentNav;
  final Function(BaseBottomBarItem) onSelected;

  const BaseBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentNav,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(color: kColorScheme.surface),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // tabs
          Positioned.fill(
            left: kSpacingX28,
            right: kSpacingX28,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...items.map(
                  (e) {
                    var active = currentNav == items.indexOf(e);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          active ? e.activeIcon : e.icon,
                          color: active
                              ? kColorScheme.secondary
                              : kColorScheme.onSurface
                                  .withOpacity(kEmphasisLow),
                        ).bottom(kSpacingX4),
                        e.label.bodyText2(
                          context,
                          color: active
                              ? kColorScheme.secondary
                              : kColorScheme.onSurface,
                          emphasis: active ? kEmphasisHigh : kEmphasisLow,
                        ),
                      ],
                    ).clickable(onTap: () => onSelected(e));
                  },
                ).toList(growable: false),
              ],
            ),
          ),

          // button
          Container(
            width: kSpacingX48,
            height: kSpacingX48,
            alignment: Alignment.center,
            child: Icon(
              Entypo.plus,
              color: kColorScheme.onSecondary,
            ),
            decoration: BoxDecoration(
              color: kColorScheme.secondary,
              shape: BoxShape.circle,
            ),
          )
              .clickable(
                onTap: () => context.router.navigate(MetricReaderRoute()),
              )
              .align(Alignment.center),
        ],
      ),
    ).centered();
  }
}
