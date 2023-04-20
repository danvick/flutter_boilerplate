import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterboilerplate/utils/http_client.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      GetIt.instance.registerLazySingleton(() => HttpClient(options: BaseOptions(baseUrl: dotenv.env['SERVER_URL']!)));
      if (!kIsWeb) {
        if (kDebugMode) {
          await FirebaseCrashlytics.instance
              .setCrashlyticsCollectionEnabled(false);
        } else {
          await FirebaseCrashlytics.instance
              .setCrashlyticsCollectionEnabled(true);
        }
      }
      if (kDebugMode) {
        await FirebasePerformance.instance
            .setPerformanceCollectionEnabled(false);
      }

      await dotenv.load(
          fileName:
              kDebugMode ? 'environments/debug.env' : 'environments/.env');
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      ErrorWidget.builder = (FlutterErrorDetails error) {
        Zone.current.handleUncaughtError(error.exception, error.stack!);
        return ErrorWidget(error.exception);
      };

      runApp(const MyApp());
    },
    (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    },
  );
}
