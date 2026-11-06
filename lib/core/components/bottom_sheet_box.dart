import 'package:flutter/material.dart';

import '../../utils/utils.dart';

/// Draggable modal bottom sheet with a handle, optional title and footer.
class BottomSheetBox extends StatelessWidget {
  const BottomSheetBox({
    super.key,
    this.title,
    this.headerAction,
    required this.child,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.3,
    this.maxChildSize = 0.9,
    this.padding = const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
    this.footer,
  });

  final String? title;
  final Widget? headerAction;
  final Widget child;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final EdgeInsetsGeometry padding;
  final Widget? footer;

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? headerAction,
    required Widget child,
    double initialChildSize = 0.5,
    double minChildSize = 0.3,
    double maxChildSize = 0.9,
    bool isDismissible = true,
    Widget? footer,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: BottomSheetBox(
          title: title,
          headerAction: headerAction,
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          footer: footer,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkCard : AppColors.surface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.border;
    final textColor = isDark ? AppColors.darkText : AppColors.ink;

    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          color: background,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: AppConstants.bottomSheetRadius,
            side: BorderSide(color: borderColor),
          ),
          child: Column(
            children: [
              const SizedBox(height: AppConstants.spacingS + 2),
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
              ),
              if (title != null || headerAction != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppConstants.spacingXL,
                    AppConstants.spacingM,
                    AppConstants.spacingM,
                    AppConstants.spacingS,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppConstants.heading.copyWith(color: textColor),
                        ),
                      ),
                      headerAction ??
                          IconButton(
                            icon: const Icon(Icons.close_rounded, size: 20),
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.inkLight,
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                    ],
                  ),
                ),
                Divider(height: 1, color: borderColor),
              ] else
                const SizedBox(height: AppConstants.spacingS),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: padding,
                  child: child,
                ),
              ),
              if (footer != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppConstants.spacingXL,
                    AppConstants.spacingS,
                    AppConstants.spacingXL,
                    AppConstants.spacingM + MediaQuery.paddingOf(context).bottom,
                  ),
                  child: footer,
                ),
            ],
          ),
        );
      },
    );
  }
}
