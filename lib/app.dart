import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter router;

  @override
  void initState() {
    super.initState();
    router = appRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Boilerplate',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
