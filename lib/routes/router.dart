import 'package:flutter/material.dart';
import 'package:fudiee/screens/auth/auth_screen.dart';
import 'package:fudiee/screens/home/home_screen.dart';
import 'package:fudiee/screens/splash/splash_screen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:go_router/go_router.dart';

part 'router.g.dart';

final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: '_navigatorKey');
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AuthScreen.routeName,
        builder: (_, __) => const AuthScreen(),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        builder: (_, __) => const HomeScreen(),
      ),
    ],
    debugLogDiagnostics: true,
    navigatorKey: _navigatorKey,
  );
}
