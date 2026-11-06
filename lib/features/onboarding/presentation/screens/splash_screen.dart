import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/components/components.dart';
import '../../../../utils/utils.dart';
import 'get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Phase 1: logo, title and tagline appear at the centre.
  late final Animation<double> _emblemReveal;
  late final Animation<double> _titleReveal;
  late final Animation<double> _taglineReveal;

  // Phase 2: logo moves up while the photo fades in.
  late final Animation<double> _moveUp;
  late final Animation<double> _backgroundFade;
  late final Animation<double> _backgroundZoom;

  // Phase 3: the version shows with the photo; the loader follows, then we leave.
  static const _loaderDelay = Duration(seconds: 1);
  static const _navigateDelay = Duration(seconds: 5);
  bool _showLoader = false;
  Timer? _loaderTimer;
  Timer? _navigateTimer;

  bool _started = false;
  bool _backgroundShown = false;

  static const _centerAlignment = Alignment.center;
  static const _finalAlignment = Alignment(0, -0.62);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) _onBackgroundShown();
      });

    _emblemReveal = _curve(0.00, 0.28, Curves.easeOutBack);
    _titleReveal = _curve(0.16, 0.38, Curves.easeOutCubic);
    _taglineReveal = _curve(0.28, 0.50, Curves.easeOutCubic);

    _moveUp = _curve(0.58, 0.92, Curves.easeInOutCubic);
    _backgroundFade = _curve(0.62, 0.97, Curves.easeOut);
    _backgroundZoom = Tween<double>(begin: 1.12, end: 1.0)
        .animate(_curve(0.62, 1.00, Curves.easeOutCubic));
  }

  void _onBackgroundShown() {
    if (_backgroundShown) return;
    _backgroundShown = true;

    _loaderTimer = Timer(_loaderDelay, () {
      if (!mounted) return;
      setState(() => _showLoader = true);
      precacheImage(const AssetImage(AppAssets.getStartedPhoto), context);
    });
    _navigateTimer = Timer(_navigateDelay, _goToGetStarted);
  }

  void _goToGetStarted() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const GetStartedScreen(),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  CurvedAnimation _curve(double begin, double end, Curve curve) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: curve),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _start();
  }

  Future<void> _start() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    // The photo is only needed in phase 2, so it decodes while phase 1 runs.
    precacheImage(const AssetImage(AppAssets.splashBackground), context);
    await precacheImage(
      AssetImage(isDark ? AppAssets.logoDark : AppAssets.logo),
      context,
    ).timeout(const Duration(milliseconds: 400), onTimeout: () {});
    if (!mounted) return;

    if (disableAnimations) {
      _controller.value = 1;
      _onBackgroundShown();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _loaderTimer?.cancel();
    _navigateTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.darkBackground : AppColors.background;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: baseColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => _buildBackground(isDark, baseColor),
            ),
            AnimatedBuilder(
              animation: _moveUp,
              builder: (context, child) => Align(
                alignment: Alignment.lerp(
                  _centerAlignment,
                  _finalAlignment,
                  _moveUp.value,
                )!,
                child: Transform.scale(
                  scale: 1.0 - 0.12 * _moveUp.value,
                  child: child,
                ),
              ),
              child: LogoComp(
                emblemAnimation: _emblemReveal,
                titleAnimation: _titleReveal,
                taglineAnimation: _taglineReveal,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedOpacity(
                        opacity: _showLoader ? 1 : 0,
                        duration: const Duration(milliseconds: 400),
                        child: const SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeTransition(
                        opacity: _backgroundFade,
                        child: const AppVersionText(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(bool isDark, Color baseColor) {
    return Opacity(
      opacity: _backgroundFade.value,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: _backgroundZoom.value,
            child: Image.asset(
              AppAssets.splashBackground,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          // Keeps the logo text readable over the bright sky.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.40, 0.58],
                colors: [
                  baseColor.withValues(alpha: isDark ? 0.92 : 0.85),
                  baseColor.withValues(alpha: isDark ? 0.55 : 0.35),
                  baseColor.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          // Lifts the loader off the busy foliage.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.black.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
