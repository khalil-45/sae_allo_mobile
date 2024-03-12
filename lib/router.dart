import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'connexion.dart';
import 'welcome.dart';

class AppRouter {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage<void>(
          key: ValueKey('/'),
          child: WelcomePage(),
        ),
      ),
      GoRoute(
        path: '/connexion',
        pageBuilder: (context, state) => const MaterialPage<void>(
          key: ValueKey('/connexion'), 
          child: Connexion(),
        ),
      ),
    ],
  );
}