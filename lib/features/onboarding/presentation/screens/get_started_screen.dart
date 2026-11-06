import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/components/components.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/utils.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final Animation<double> _textReveal = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
  );
  late final Animation<double> _imageReveal = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.2, 0.85, curve: Curves.easeOutCubic),
  );
  late final Animation<double> _actionsReveal = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.45, 1.0, curve: Curves.easeOutCubic),
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onGetStarted() {}

  void _onHowItWorks() {}

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : AppColors.background;

    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: _SlideFade(
              animation: _textReveal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.spacing2XL,
                  AppConstants.spacing3XL,
                  AppConstants.spacing2XL,
                  0,
                ),
                child: _FeatureCarousel(
                  features: [
                    (l10n.featureOneTitle, l10n.featureOneBody),
                    (l10n.featureTwoTitle, l10n.featureTwoBody),
                    (l10n.featureThreeTitle, l10n.featureThreeBody),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: FadeTransition(
              opacity: _imageReveal,
              child: _WavyPhoto(background: background),
            ),
          ),

          SafeArea(
            top: false,
            child: _SlideFade(
              animation: _actionsReveal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.spacing2XL,
                  AppConstants.spacingS,
                  AppConstants.spacing2XL,
                  AppConstants.spacingS,
                ),
                child: Column(
                  children: [
                    
                    AppButton(
                      text: l10n.getStarted,
                      suffixIcon: Icons.arrow_forward_rounded,
                      borderRadius: AppConstants.radiusL,
                      onPressed: _onGetStarted,
                    ),

                    const SizedBox(height: AppConstants.spacingS),
                    
                    TextButton(
                      onPressed: _onHowItWorks,
                      child: Text(l10n.howItWorks),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Rotating feature title + description with page dots.
///
/// Auto-advances, can be swiped, and dots are tappable. The block keeps the
/// height of its tallest feature so the content below never jumps.
class _FeatureCarousel extends StatefulWidget {
  const _FeatureCarousel({required this.features});

  final List<(String title, String body)> features;

  @override
  State<_FeatureCarousel> createState() => _FeatureCarouselState();
}

class _FeatureCarouselState extends State<_FeatureCarousel> {
  static const _interval = Duration(seconds: 4);

  int _index = 0;
  int _direction = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _restartTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _restartTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_interval, (_) => _goTo(_index + 1, restart: false));
  }

  void _goTo(int index, {int? direction, bool restart = true}) {
    final next = index % widget.features.length;
    if (next == _index) return;
    setState(() {
      _direction = direction ?? (index > _index ? 1 : -1);
      _index = next;
    });
    if (restart) _restartTimer();
  }

  void _onSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 150) return;
    if (velocity < 0) {
      _goTo(_index + 1, direction: 1);
    } else {
      _goTo(_index - 1, direction: -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragEnd: _onSwipe,
          child: Stack(
            children: [
              for (final feature in widget.features)
                Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: _FeatureText(feature: feature, isDark: isDark),
                ),
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  layoutBuilder: (current, previous) => Stack(
                    alignment: Alignment.topLeft,
                    children: [...previous, ?current],
                  ),
                  transitionBuilder: (child, animation) {
                    final isIncoming = child.key == ValueKey(_index);
                    final dx = 0.08 * _direction * (isIncoming ? 1 : -1);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(dx, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _FeatureText(
                    key: ValueKey(_index),
                    feature: widget.features[_index],
                    isDark: isDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingXL),
        AnimatedSmoothIndicator(
          activeIndex: _index,
          count: widget.features.length,
          onDotClicked: _goTo,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            expansionFactor: 3,
            spacing: 6,
            activeDotColor: isDark ? AppColors.darkEmerald : AppColors.forest,
            dotColor: isDark ? AppColors.darkBorder : AppColors.border,
          ),
        ),
      ],
    );
  }
}

class _FeatureText extends StatelessWidget {
  const _FeatureText({super.key, required this.feature, required this.isDark});

  final (String title, String body) feature;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feature.$1,
          style: AppConstants.display.copyWith(
            color: isDark ? AppColors.darkEmerald : AppColors.forest,
          ),
        ),
        const SizedBox(height: AppConstants.spacingL),
        Text(
          feature.$2,
          style: AppConstants.bodyLarge.copyWith(
            color: isDark ? AppColors.darkText : AppColors.ink,
          ),
        ),
      ],
    );
  }
}

/// Tea-harvest photo with a wavy top edge that fades into the page at the bottom.
class _WavyPhoto extends StatelessWidget {
  const _WavyPhoto({required this.background});

  final Color background;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _WaveClipper(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.getStartedPhoto,
            fit: BoxFit.cover,
            alignment: const Alignment(0.15, 0),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [background, background.withValues(alpha: 0)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    return Path()
      ..moveTo(0, h * 0.22)
      ..cubicTo(w * 0.28, h * 0.02, w * 0.52, h * 0.30, w * 0.78, h * 0.10)
      ..quadraticBezierTo(w * 0.90, h * 0.01, w, h * 0.03)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _SlideFade extends StatelessWidget {
  const _SlideFade({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
