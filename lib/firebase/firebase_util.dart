import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kIsWeb, PlatformDispatcher;
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'appInsights/event_logger.dart';

class FirebaseUtil {
  static Future<void> runAppWithFirebase({required Widget app}) async {
    await PlatformHandler.initializeApp(app);
  }
}

class PlatformHandler {
  static Future<void> initializeApp(Widget app) async {
    if (kIsWeb) {
      runApp(app);
    } else {
      await runZonedGuarded(() async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

        // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };

        await EventLogger.instance.initialize();

        runApp(app);
      }, (error, stackTrace) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace);
      });
    }
  }
}
