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
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('/connexion'),
          child: Connexion(),
        ),
      ),
    ],
  );
}

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      selectedItemColor: Colors.amber[800],
    );
  }
}
