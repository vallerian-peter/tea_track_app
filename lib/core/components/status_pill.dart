import 'package:flutter/material.dart';

import '../../utils/utils.dart';

enum StatusType { success, warning, error, info, neutral }

/// Small rounded status label, e.g. "Synced", "Pending", "Rejected".
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.type = StatusType.neutral,
    this.icon,
  });

  final String label;
  final StatusType type;
  final IconData? icon;

  (Color foreground, Color background) _colors(bool isDark) {
    final (fg, bg) = switch (type) {
      StatusType.success => (AppColors.success, AppColors.successBg),
      StatusType.warning => (AppColors.warning, AppColors.warningBg),
      StatusType.error => (AppColors.error, AppColors.errorBg),
      StatusType.info => (AppColors.info, AppColors.infoBg),
      StatusType.neutral => (AppColors.inkLight, AppColors.surfaceMuted),
    };
    if (!isDark) return (fg, bg);
    return (Color.lerp(fg, Colors.white, 0.35)!, fg.withValues(alpha: 0.18));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final (foreground, background) = _colors(isDark);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingS + 2,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: foreground),
            const SizedBox(width: AppConstants.spacingXS),
          ],
          Text(
            label,
            style: AppConstants.caption.copyWith(
              color: foreground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
