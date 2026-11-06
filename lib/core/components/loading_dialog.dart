import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/utils.dart';
import 'app_button.dart';

/// Blocking loading overlay.
///
/// ```dart
/// LoadingDialog.show(context, message: 'Syncing...');
/// await work();
/// if (context.mounted) LoadingDialog.hide(context);
/// ```
abstract final class LoadingDialog {
  static Future<void> show(BuildContext context, {String? message}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => PopScope(
        canPop: false,
        child: _LoadingCard(message: message),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkEmerald : AppColors.forest;

    return Center(
      child: Material(
        color: isDark ? AppColors.darkCard : AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacing3XL,
            vertical: AppConstants.spacing2XL,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ThreeDotsWave(color: accent, dotSize: 9),
              const SizedBox(height: AppConstants.spacingL),
              Text(
                message ?? AppLocalizations.of(context).pleaseWait,
                style: AppConstants.body.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
