import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'connexion.dart';
import 'welcome.dart';

class AppRouter {

  final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>();
  
  
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
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
