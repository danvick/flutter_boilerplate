import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(false);
  }
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  await dotenv.load(
      fileName: kDebugMode ? 'environment/debug.env' : 'environment/.env');

  await runZonedGuarded(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    ErrorWidget.builder = (FlutterErrorDetails error) {
      Zone.current.handleUncaughtError(error.exception, error.stack!);
      return ErrorWidget(error.exception);
    };

    runApp(App());
  }, (exception, stackTrace) {
    FirebaseCrashlytics.instance.recordError(exception, stackTrace);
  });
}

Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
  print('onBackgroundMessage $message');
  // TODO: handle background message
}
