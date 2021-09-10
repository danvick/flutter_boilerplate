import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // Consider putting your analytics instance in a state manager to allow sharing the instance throughout the app
  final FirebaseAnalytics analytics = FirebaseAnalytics();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    );
  }
}