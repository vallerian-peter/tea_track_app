import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/utils.dart';
import 'status_pill.dart';

enum AppStepperOrientation { horizontal, vertical }

class AppStepItem {
  const AppStepItem({
    required this.title,
    this.subtitle,
    this.icon,
    this.content,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;

  /// Shown under the active step in the vertical layout.
  final Widget? content;
}

/// Progress stepper for multi-stage flows, e.g.
/// Plucking → Weighing → Collection → Transport → Factory.
class AppStepper extends StatelessWidget {
  const AppStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    this.onStepTapped,
    this.orientation = AppStepperOrientation.horizontal,
  });

  final List<AppStepItem> steps;
  final int currentStep;
  final ValueChanged<int>? onStepTapped;
  final AppStepperOrientation orientation;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return orientation == AppStepperOrientation.horizontal
        ? _buildHorizontal(context, isDark)
        : _buildVertical(context, isDark);
  }

  Color _lineColor(bool isCompleted, bool isDark) {
    if (isCompleted) return isDark ? AppColors.darkEmerald : AppColors.leaf;
    return isDark ? AppColors.darkBorder : AppColors.border;
  }

  Widget _buildHorizontal(BuildContext context, bool isDark) {
    final nodeWidth = steps.length > 4 ? 60.0 : 74.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          if (i > 0)
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 17),
                height: 3,
                decoration: BoxDecoration(
                  color: _lineColor(i <= currentStep, isDark),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          GestureDetector(
            onTap: onStepTapped == null ? null : () => onStepTapped!(i),
            child: SizedBox(
              width: nodeWidth,
              child: Column(
                children: [
                  _StepIndicator(
                    index: i,
                    currentStep: currentStep,
                    icon: steps[i].icon,
                  ),
                  const SizedBox(height: AppConstants.spacingS - 2),
                  Text(
                    steps[i].title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppConstants.caption.copyWith(
                      fontWeight: i == currentStep
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: i == currentStep
                          ? (isDark ? AppColors.darkEmerald : AppColors.forest)
                          : (isDark
                              ? AppColors.darkTextMuted
                              : AppColors.inkMuted),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVertical(BuildContext context, bool isDark) {
    final l10n = AppLocalizations.of(context);
    final textColor = isDark ? AppColors.darkText : AppColors.ink;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.inkLight;
    final accent = isDark ? AppColors.darkEmerald : AppColors.leaf;

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _StepIndicator(
                      index: i,
                      currentStep: currentStep,
                      icon: steps[i].icon,
                    ),
                    if (i < steps.length - 1)
                      Expanded(
                        child: Container(
                          width: 2.5,
                          margin: const EdgeInsets.symmetric(
                            vertical: AppConstants.spacingXS,
                          ),
                          color: _lineColor(i < currentStep, isDark),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: AppConstants.spacingM),
                Expanded(
                  child: GestureDetector(
                    onTap: onStepTapped == null ? null : () => onStepTapped!(i),
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: i == steps.length - 1 ? 0 : AppConstants.spacingL,
                      ),
                      padding: const EdgeInsets.all(AppConstants.spacingM + 2),
                      decoration: BoxDecoration(
                        color: i == currentStep
                            ? accent.withValues(alpha: isDark ? 0.12 : 0.08)
                            : (isDark ? AppColors.darkCard : AppColors.surface),
                        borderRadius: BorderRadius.circular(AppConstants.radiusM),
                        border: Border.all(
                          color: i == currentStep
                              ? accent
                              : (isDark ? AppColors.darkBorder : AppColors.border),
                          width: i == currentStep ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  steps[i].title,
                                  style: AppConstants.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              if (i < currentStep)
                                StatusPill(
                                  label: l10n.stepDone,
                                  type: StatusType.success,
                                ),
                              if (i == currentStep)
                                StatusPill(
                                  label: l10n.stepCurrent,
                                  type: StatusType.warning,
                                ),
                            ],
                          ),
                          if (steps[i].subtitle != null) ...[
                            const SizedBox(height: AppConstants.spacingXS),
                            Text(
                              steps[i].subtitle!,
                              style: AppConstants.bodySmall.copyWith(
                                color: mutedColor,
                              ),
                            ),
                          ],
                          if (steps[i].content != null && i == currentStep) ...[
                            const SizedBox(height: AppConstants.spacingM),
                            steps[i].content!,
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.index,
    required this.currentStep,
    this.icon,
  });

  final int index;
  final int currentStep;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const size = 36.0;

    if (index < currentStep) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkEmerald : AppColors.leaf,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          size: 20,
          color: isDark ? AppColors.darkBackground : Colors.white,
        ),
      );
    }

    if (index == currentStep) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: isDark
              ? AppColors.primaryGradientDark
              : AppColors.primaryGradient,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.gold, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 18, color: Colors.white)
              : Text(
                  '${index + 1}',
                  style: AppConstants.label.copyWith(color: Colors.white),
                ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: AppConstants.label.copyWith(
            color: isDark ? AppColors.darkTextMuted : AppColors.inkMuted,
          ),
        ),
      ),
    );
  }
}
