import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/views/connexion.dart';
import 'package:sae_allo_mobile/views/welcome.dart';

final GlobalKey<NavigatorState> _goRouterKey = GlobalKey<NavigatorState>();


class AppRouter {

  get router => _router;


  late final GoRouter _router = GoRouter(
    routes: [
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