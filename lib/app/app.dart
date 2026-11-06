import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tea_track_app/features/onboarding/onboarding.dart';
import '../core/core.dart';
import '../l10n/app_localizations.dart';
import '../utils/utils.dart';


class TeaTrackApp extends StatelessWidget {
  final AppDatabase? database;

  const TeaTrackApp({super.key, this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) => database ?? AppDatabase(),
          dispose: (_, db) => db.close(),
        ),
        Provider<FarmersDao>(
          create: (ctx) => FarmersDao(ctx.read<AppDatabase>()),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => NetworkStatusProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appName,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            locale: localeProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}