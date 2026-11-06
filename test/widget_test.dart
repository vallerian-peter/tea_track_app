import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tea_track_app/app/app.dart';
import 'package:tea_track_app/core/core.dart';
import 'package:tea_track_app/features/onboarding/onboarding.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'TeaTrack',
      packageName: 'com.example.tea_track_app',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    await StorageManager.init(customPrefs: PreferencesService());
  });

  testWidgets('splash shows the brand, then the loader, then Get Started',
      (tester) async {
    await tester.pumpWidget(
      TeaTrackApp(database: AppDatabase(NativeDatabase.memory())),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Entrance animation (logo, then background photo).
    await tester.pump(const Duration(milliseconds: 2900));
    expect(find.text('TeaTrack'), findsOneWidget);
    expect(find.text('From Farmers to Factories'), findsOneWidget);
    expect(find.text('App Version: 1.0.0+1'), findsOneWidget);

    // Loader appears 1s after the photo.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 500));

    // Navigation 5s after the photo.
    await tester.pump(const Duration(milliseconds: 3600));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(GetStartedScreen), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    expect(find.text('How it works'), findsOneWidget);
  });
}
