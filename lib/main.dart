import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(
      fileName: kDebugMode ? 'environment/dev.env' : 'environment/.env');

  await runZonedGuarded(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    ErrorWidget.builder = (FlutterErrorDetails error) {
      Zone.current.handleUncaughtError(error.exception, error.stack);
      return ErrorWidget(error.exception);
    };

    runApp(MyApp());
  }, (exception, stackTrace) {
    FirebaseCrashlytics.instance.recordError(exception, stackTrace);
  });
}
