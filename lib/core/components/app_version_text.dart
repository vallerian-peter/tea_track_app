import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/utils.dart';
import '../app_info/app_info.dart';

/// Bold "App Version: 1.0.0+1" label.
class AppVersionText extends StatelessWidget {
  const AppVersionText({super.key, this.color, this.fontSize = 12});

  final Color? color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppInfo.load(),
      builder: (context, snapshot) {
        final version = AppInfo.fullVersion;
        if (version.isEmpty) return const SizedBox.shrink();
        return Text(
          AppLocalizations.of(context).appVersion(version),
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color ?? Theme.of(context).colorScheme.onSurface,
          ),
        );
      },
    );
  }
}
