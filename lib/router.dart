import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'vues/connexion.dart';
import 'vues/welcome.dart';
import 'vues/home.dart';
import 'components/bottom_navigation_bar.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/welcome',
      routes: [
        GoRoute(
          path: '/welcome',
          pageBuilder: (context, state) => const MaterialPage(child: WelcomePage()),
        ),
        GoRoute(
          path: '/connexion',
            pageBuilder: (context, state) => const MaterialPage(child: ConnexionPage()),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => MaterialPage(
            child: Scaffold(
              body: const HomePage(),
              bottomNavigationBar: BottomNavBar(router),
            ),
          ),
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage(
  child: Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Page non trouvé !'),
          TextButton(
            child: const Text('Go to Home'),
            onPressed: () => router.go('/home'),
          ),
        ],
      ),
    ),
  ),
)
    );
  }
}