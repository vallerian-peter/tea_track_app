import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/utils.dart';

/// TeaTrack logo: emblem, optional "TeaTrack" title and optional tagline.
///
/// Text sizes scale with [size]. Pass the optional animations (0 → 1) to
/// reveal each part individually, e.g. for the splash entrance.
class LogoComp extends StatelessWidget {
  const LogoComp({
    super.key,
    this.size = 150,
    this.showTitle = true,
    this.showTagline = true,
    this.emblemAnimation,
    this.titleAnimation,
    this.taglineAnimation,
  });

  /// Emblem width.
  final double size;
  final bool showTitle;
  final bool showTagline;

  final Animation<double>? emblemAnimation;
  final Animation<double>? titleAnimation;
  final Animation<double>? taglineAnimation;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Reveal(
          animation: emblemAnimation,
          scaleFrom: 0.6,
          child: Image.asset(
            isDark ? AppAssets.logoDark : AppAssets.logo,
            width: size,
          ),
        ),
        if (showTitle) ...[
          SizedBox(height: size * 0.13),
          _Reveal(
            animation: titleAnimation,
            slideFrom: 0.4,
            child: _Title(fontSize: size * 0.29, isDark: isDark),
          ),
        ],
        if (showTagline) ...[
          SizedBox(height: size * 0.05),
          _Reveal(
            animation: taglineAnimation,
            slideFrom: 0.6,
            child: _Tagline(fontSize: (size * 0.1).clamp(11, 18), isDark: isDark),
          ),
        ],
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.fontSize, required this.isDark});

  final double fontSize;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Tea',
            style: TextStyle(
              color: isDark ? AppColors.darkEmerald : AppColors.forest,
            ),
          ),
          const TextSpan(
            text: 'Track',
            style: TextStyle(color: AppColors.gold),
          ),
        ],
      ),
      style: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        height: 1.1,
        letterSpacing: -0.5,
      ),
    );
  }
}

class _Tagline extends StatelessWidget {
  const _Tagline({required this.fontSize, required this.isDark});

  final double fontSize;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final rule = Container(
      width: fontSize * 1.5,
      height: 1.5,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(1),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        rule,
        SizedBox(width: fontSize * 0.65),
        Text(
          AppLocalizations.of(context).appTagline,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: fontSize,
            color: isDark ? AppColors.darkText : AppColors.forest,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(width: fontSize * 0.65),
        rule,
      ],
    );
  }
}

/// Fades a child in, optionally scaling up or sliding up as [animation] runs.
class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.animation,
    required this.child,
    this.scaleFrom = 1,
    this.slideFrom = 0,
  });

  final Animation<double>? animation;
  final Widget child;
  final double scaleFrom;
  final double slideFrom;

  @override
  Widget build(BuildContext context) {
    final animation = this.animation;
    if (animation == null) return child;

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final t = animation.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: FractionalTranslation(
            translation: Offset(0, slideFrom * (1 - t)),
            child: Transform.scale(
              scale: scaleFrom + (1 - scaleFrom) * t,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
