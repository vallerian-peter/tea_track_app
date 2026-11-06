import 'package:flutter/material.dart';

import '../../utils/utils.dart';

enum AppButtonVariant { filled, outlined }

/// Primary TeaTrack button.
///
/// - Full width by default, or a fixed [width]
/// - Gradient fill (light/dark aware) or outlined variant
/// - Optional prefix and suffix icons
/// - Three-dot loading animation while [isLoading]
/// - Disabled when [onPressed] is null
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = AppConstants.buttonHeight,
    this.borderRadius = AppConstants.radiusM,
    this.prefixIcon,
    this.suffixIcon,
    this.gradient,
    this.textColor,
    this.borderColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Gradient? gradient;
  final Color? textColor;
  final Color? borderColor;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  double _scale = 1.0;

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  void _setPressed(bool pressed) {
    if (!_isEnabled) return;
    setState(() => _scale = pressed ? 0.97 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOutlined = widget.variant == AppButtonVariant.outlined;
    final radius = BorderRadius.circular(widget.borderRadius);

    final gradient = widget.gradient ??
        (isDark ? AppColors.primaryGradientDark : AppColors.primaryGradient);
    final disabledGradient = LinearGradient(
      colors: [Colors.grey.shade400, Colors.grey.shade500],
    );
    final accent = isDark ? AppColors.darkEmerald : AppColors.forest;
    final foreground =
        widget.textColor ?? (isOutlined ? accent : Colors.white);

    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 80),
      curve: Curves.easeOut,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: isOutlined
                ? null
                : (_isEnabled || widget.isLoading ? gradient : disabledGradient),
            borderRadius: radius,
            border: isOutlined
                ? Border.all(
                    color: widget.borderColor ??
                        (_isEnabled ? accent : Colors.grey.shade400),
                    width: 1.5,
                  )
                : null,
            boxShadow: _isEnabled && !isOutlined
                ? [
                    BoxShadow(
                      color: (isDark ? Colors.black : AppColors.forest)
                          .withValues(alpha: isDark ? 0.3 : 0.22),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isEnabled ? widget.onPressed : null,
              onTapDown: (_) => _setPressed(true),
              onTapUp: (_) => _setPressed(false),
              onTapCancel: () => _setPressed(false),
              borderRadius: radius,
              splashColor: Colors.white.withValues(alpha: 0.15),
              highlightColor: Colors.white.withValues(alpha: 0.08),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingL,
                ),
                child: Center(
                  child: widget.isLoading
                      ? ThreeDotsWave(color: foreground)
                      : _buildLabel(foreground),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(Color color) {
    final disabledColor = widget.variant == AppButtonVariant.outlined
        ? Colors.grey.shade500
        : Colors.white;
    final effectiveColor = _isEnabled ? color : disabledColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.prefixIcon != null) ...[
          Icon(widget.prefixIcon, size: 20, color: effectiveColor),
          const SizedBox(width: AppConstants.spacingS + 2),
        ],
        Flexible(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppConstants.button.copyWith(color: effectiveColor),
          ),
        ),
        if (widget.suffixIcon != null) ...[
          const SizedBox(width: AppConstants.spacingS + 2),
          Icon(widget.suffixIcon, size: 20, color: effectiveColor),
        ],
      ],
    );
  }
}

/// Three bouncing dots, used as a compact loading indicator.
class ThreeDotsWave extends StatefulWidget {
  const ThreeDotsWave({super.key, this.color = Colors.white, this.dotSize = 7.5});

  final Color color;
  final double dotSize;

  @override
  State<ThreeDotsWave> createState() => _ThreeDotsWaveState();
}

class _ThreeDotsWaveState extends State<ThreeDotsWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final t = (_controller.value - index * 0.2).clamp(0.0, 1.0);
            final bounce = Curves.easeInOut.transform(
              (1.0 - (2.0 * t - 1.0).abs()).clamp(0.0, 1.0),
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.5),
              child: Transform.translate(
                offset: Offset(0, -6.0 * bounce),
                child: Transform.scale(
                  scale: 0.8 + 0.45 * bounce,
                  child: Container(
                    width: widget.dotSize,
                    height: widget.dotSize,
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.4 + 0.6 * bounce),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
