import 'package:flutter/material.dart';

import '../../utils/utils.dart';

/// Segmented progress bars with an optional caption, e.g.
/// "Step 2 of 4 · Farm details". Good for multi-page forms.
class AppStepBars extends StatelessWidget {
  const AppStepBars({
    super.key,
    required this.count,
    required this.current,
    this.caption,
    this.onBarTapped,
  });

  final int count;

  /// Zero-based index of the current step.
  final int current;
  final String? caption;

  /// Called with the index of a completed bar; later bars are not tappable.
  final ValueChanged<int>? onBarTapped;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final idle = isDark ? AppColors.darkBorder : AppColors.border;
    final active = isDark ? AppColors.darkEmerald : AppColors.leaf;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            for (var i = 0; i < count; i++) ...[
              if (i > 0) const SizedBox(width: AppConstants.spacingS - 2),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onBarTapped != null && i < current
                      ? () => onBarTapped!(i)
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      height: 5,
                      decoration: BoxDecoration(
                        color: i <= current ? active : idle,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (caption != null)
          Text(
            caption!,
            style: AppConstants.caption.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.ink,
            ),
          ),
      ],
    );
  }
}
