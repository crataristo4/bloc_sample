/// File: buttons.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 6:18:59 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Tuesday, May 25th 2021 6:27:11 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:shared_utils/shared_utils.dart';

// rounded button
class RoundedButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingX24,
          vertical: kSpacingX16,
        ),
        decoration: BoxDecoration(
          color: kColorScheme.secondary,
          borderRadius: BorderRadius.circular(kSpacingX24),
        ),
        child: label.button(
          context,
          color: kColorScheme.onSecondary,
        ),
      ),
    );
  }
}
