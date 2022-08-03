import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home_page.dart';

GoRouter appRouter() => GoRouter(
      debugLogDiagnostics: kDebugMode,
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          name: HomePage.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const HomePage(),
        ),
      ],
      observers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      /*refreshListenable: GoRouterRefreshStream(),
      redirect: (state) {
        String? redirectRoute;
        return state.subloc == redirectRoute ? null : redirectRoute;
      },*/
    );
