import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// Saves every screenshot taken in integration_test/ to screenshots/.
Future<void> main() => integrationDriver(
  onScreenshot: (name, bytes, [args]) async {
    final file = await File('screenshots/$name.png').create(recursive: true);
    await file.writeAsBytes(bytes);
    return true;
  },
);
