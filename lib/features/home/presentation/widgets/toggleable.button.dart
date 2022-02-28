/// File: toggleable.button.dart
/// Project: mobile
/// Created Date: Friday, May 28th 2021, 3:49:25 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Friday, May 28th 2021 4:43:11 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:shared_utils/shared_utils.dart';

/// toggle enabled buttons
class ToggleableButton extends StatelessWidget {
  final int active;
  final Function(int) onToggle;
  final List<String> labels;

  const ToggleableButton({
    Key? key,
    required this.active,
    required this.onToggle,
    required this.labels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: kColorScheme.surface,
        borderRadius: BorderRadius.circular(kSpacingX40),
      ),
      padding: EdgeInsets.all(kSpacingX6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var label in labels) ...{
            _buildTab(
              context,
              kColorScheme,
              label,
              label == labels[active],
            ),
          },
        ],
      ),
    );
  }

  Widget _buildTab(
      context, ColorScheme kColorScheme, String label, bool isActive) {
    var br = BorderRadius.circular(kSpacingX40);
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingX20,
          vertical: kSpacingX12,
        ),
        decoration: BoxDecoration(
          color: isActive ? kColorScheme.background : kColorScheme.surface,
          borderRadius: isActive ? br : null,
        ),
        child: label.subtitle2(
          context,
          color: isActive ? kColorScheme.onBackground : kColorScheme.onSurface,
        ),
      ).clickable(onTap: () => onToggle(labels.indexOf(label))),
    );
  }
}
