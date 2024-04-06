import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final GoRouter router;
  const BottomNavBar(this.router, {Key? key}) : super(key: key);

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
          label: 'Mes annonces',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Profil',
        ),
      ],
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        switch (index) {
          case 0:
            router.go('/home');
            break;
          case 1:
            router.go('/mes-annonces');
            break;
          case 2:
            router.go('/profil');
            break;
        }
      },
    );
  }
}
