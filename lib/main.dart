import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageManager.init();
  await AppEnvironment.load();
  await AppInfo.load();

  runApp(
    TeaTrackApp(
      database: AppDatabase()
    )
  );
}
