import 'package:flutter/material.dart';
import 'package:fudiee/screens/auth/auth.screen.dart';
import 'package:fudiee/screens/cart/cart.screen.dart';
import 'package:fudiee/screens/printer/printer.screen.dart';
import 'package:fudiee/screens/receipt/receipt.screen.dart';
import 'package:fudiee/screens/receipt/receipts.screen.dart';
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
        path: ReceiptsScreen.routePath,
        name: ReceiptsScreen.name,
        builder: (_, __) => const ReceiptsScreen(),
      ),
      GoRoute(
        path: CartScreen.routePath,
        name: CartScreen.name,
        builder: (_, state) {
          return CartScreen();
        },
      ),
      GoRoute(
        path: ReceiptScreen.routePath,
        name: ReceiptScreen.name,
        builder: (_, state) {
          return ReceiptScreen();
        },
      ),
      GoRoute(
        path: PrinterScreen.routePath,
        name: PrinterScreen.name,
        builder: (_, state) {
          return PrinterScreen();
        },
      ),
    ],
    debugLogDiagnostics: true,
    navigatorKey: _navigatorKey,
  );
}
