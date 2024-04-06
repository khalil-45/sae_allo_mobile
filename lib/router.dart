import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/connexion.dart';
import 'views/welcome.dart';

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
        }
      ),
    ],
  );
}