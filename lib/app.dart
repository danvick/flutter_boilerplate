import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Consider putting your analytics instance in a state manager to allow sharing the instance throughout the app
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  void initState() {
    super.initState();
    // When app (terminated) is opened when user taps notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('getInitialMessage: $message');
      if (message != null) {
        messageHandler(message);
      }
    });
    // When app (in foreground) receives message while in use
    FirebaseMessaging.onMessage.listen((message) async {
      print('onMessage: $message');
      messageHandler(message);
    });
    // When app (in background) is opened when user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('onMessageOpenedApp: $message');
      messageHandler(message);
    });
    handleFcmToken();
  }

  void messageHandler(RemoteMessage message) {
    // TODO: handle remote message
    print('Received message $message');
  }

  void handleFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      await saveFcmToken(fcmToken);
    }
    // Any time the fcmToken refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveFcmToken);
  }

  Future<void> saveFcmToken(String token) async {
    //TODO: Save message to backend
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    );
  }
}
