import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/views/home.dart';
import 'views/connexion.dart';
import 'views/welcome.dart';

import 'components/bottom_navigation_bar.dart';

final GlobalKey<NavigatorState> _goRouterKey = GlobalKey<NavigatorState>();


class AppRouter {


  get router => _router;


  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    navigatorKey: _goRouterKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const WelcomePage();
        }
      ),
      GoRoute(
        path: '/connexion',
        builder: (context, state) {
          return const Connexion();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomePage();
        }
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
      ),
    );
}
