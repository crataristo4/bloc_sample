/// File: feature.tile.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 9:09:15 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 17th 2021 7:55:35 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/util/feature.dart';
import 'package:shared_utils/shared_utils.dart';

/// feature tile
class FeatureTile extends StatelessWidget {
  final BaseFeature feature;
  final String stats;
  final String statsDesc;

  const FeatureTile({
    Key? key,
    required this.feature,
    required this.stats,
    required this.statsDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: kColorScheme.surface,
        borderRadius: BorderRadius.circular(kSpacingX12),
      ),
      child: Stack(
        children: [
          // background image
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(feature.backgroundColor)),
            ),
          ),

          Positioned(
            left: kSpacingX12,
            right: kSpacingX8,
            top: kSpacingX16,
            bottom: kSpacingX8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // icon & title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(feature.icon, color: Color(feature.color))
                        .right(kSpacingX12),
                    Expanded(
                      child: feature.name.subtitle1(
                        context,
                        color: Color(feature.color),
                      ),
                    ),
                  ],
                ).bottom(kSpacingX24),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // stats
                      stats
                          .h5(context,
                              color: Color(feature.color)
                                  .withOpacity(kEmphasisHigh))
                          .bottom(kSpacingX4),
                      Expanded(
                        child: statsDesc.bodyText2(context,
                            color: Color(feature.color)
                                .withOpacity(kEmphasisMedium)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ).clickable(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: kColorScheme.surface,
          clipBehavior: Clip.hardEdge,
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: SizeConfig.kDeviceHeight * 0.25,
                width: SizeConfig.kDeviceWidth,
                child: Container(
                  child: Icon(
                    feature.icon,
                    size: kSpacingX64,
                    color: Color(feature.backgroundColor),
                  ).centered(),
                ),
              ).bottom(kSpacingX12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  feature.fullName.h6(
                    context,
                    color: kColorScheme.onSurface,
                  ),
                  feature.description
                      .bodyText1(
                        context,
                        color: kColorScheme.onSurface,
                      )
                      .top(kSpacingX8),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.router.pop(),
              child: 'Got it'.button(
                context,
                color: kColorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
