import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

/// Colours and decoration shared by every TeaTrack input.
class InputStyles {
  InputStyles.of(BuildContext context)
      : isDark = Theme.of(context).brightness == Brightness.dark;

  final bool isDark;

  Color get text => isDark ? AppColors.darkText : AppColors.ink;
  Color get hint => isDark ? AppColors.darkTextMuted : AppColors.inkMuted;
  Color get fill => isDark ? AppColors.darkSurface : AppColors.surface;
  Color get fillMuted => isDark ? AppColors.darkCard : AppColors.surfaceMuted;
  Color get border => isDark ? AppColors.darkBorder : AppColors.border;
  Color get focus => isDark ? AppColors.darkEmerald : AppColors.forest;
  Color get accent => isDark ? AppColors.darkEmerald : AppColors.leaf;

  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: AppConstants.spacingL,
    vertical: AppConstants.spacingM + 2,
  );

  TextStyle get textStyle => AppConstants.body.copyWith(color: text, height: 1.2);

  TextStyle get hintStyle => AppConstants.body.copyWith(color: hint, height: 1.2);

  OutlineInputBorder outline(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  /// Box decoration for tap-to-open fields (date, large selects).
  BoxDecoration box({bool hasError = false}) {
    return BoxDecoration(
      color: fill,
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      border: Border.all(color: hasError ? AppColors.error : border),
    );
  }

  InputDecoration decoration({
    String? hintText,
    String? helperText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      helperText: helperText,
      helperMaxLines: 2,
      helperStyle: AppConstants.caption.copyWith(color: hint),
      errorStyle: AppConstants.caption.copyWith(color: AppColors.error),
      filled: true,
      fillColor: fill,
      contentPadding: contentPadding,
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 40),
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 40),
      border: outline(border),
      enabledBorder: outline(border),
      disabledBorder: outline(border.withValues(alpha: 0.5)),
      focusedBorder: outline(focus, 1.5),
      errorBorder: outline(AppColors.error),
      focusedErrorBorder: outline(AppColors.error, 1.5),
    );
  }
}

/// Field label with an optional red required marker.
class InputLabel extends StatelessWidget {
  const InputLabel(this.text, {super.key, this.isRequired = false});

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final styles = InputStyles.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingS - 2),
      child: Text.rich(
        TextSpan(
          text: text,
          children: [
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.error),
              ),
          ],
        ),
        style: AppConstants.label.copyWith(color: styles.text),
      ),
    );
  }
}

/// Small error line shown under tap-to-open fields.
class InputErrorText extends StatelessWidget {
  const InputErrorText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppConstants.spacingL,
        top: AppConstants.spacingXS + 2,
      ),
      child: Text(
        text,
        style: AppConstants.caption.copyWith(color: AppColors.error),
      ),
    );
  }
}
