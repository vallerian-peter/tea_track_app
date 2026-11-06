import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/utils.dart';
import 'app_button.dart';

/// Centered placeholder for empty lists and screens.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.icon = Icons.eco_outlined,
    this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String? title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkEmerald : AppColors.leaf;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing3XL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 38, color: accent),
            ),
            const SizedBox(height: AppConstants.spacingL),
            Text(
              title ?? AppLocalizations.of(context).nothingHereYet,
              textAlign: TextAlign.center,
              style: AppConstants.heading.copyWith(
                color: isDark ? AppColors.darkText : AppColors.ink,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: AppConstants.spacingS),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppConstants.body.copyWith(
                  color: isDark ? AppColors.darkTextMuted : AppColors.inkMuted,
                ),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppConstants.spacingXL),
              AppButton(
                text: actionLabel!,
                onPressed: onAction,
                width: null,
                height: AppConstants.buttonHeightSmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
