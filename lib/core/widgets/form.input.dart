/// File: form.input.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 7:01:22 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Wednesday, May 26th 2021 6:20:22 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:shared_utils/shared_utils.dart';

/// form input field
class FormInputField extends StatelessWidget {
  final String hint;
  final String label;
  final Function(String?)? onSubmit;
  final TextEditingController? controller;
  final bool enabled;
  final TextInputType? inputType;
  final TextCapitalization capitalization;

  const FormInputField({
    Key? key,
    required this.hint,
    required this.label,
    this.onSubmit,
    this.controller,
    this.capitalization = TextCapitalization.sentences,
    this.inputType = TextInputType.text,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: kTheme.textTheme.bodyText1?.copyWith(
            color: kColorScheme.onBackground.withOpacity(kEmphasisMedium),
          ),
          alignLabelWithHint: true,
        ),
        style: kTheme.textTheme.bodyText1?.copyWith(
          color: kColorScheme.onBackground,
        ),
        controller: controller,
        enabled: enabled,
        keyboardType: inputType,
        textCapitalization: capitalization,
        onFieldSubmitted: (_) => onSubmit == null ? null : onSubmit!(_),
        maxLines: 1,
        textInputAction: TextInputAction.done,
        enableInteractiveSelection: true,
      ),
    );
  }
}
