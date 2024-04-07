import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'vues/connexion_page.dart';
import 'vues/welcome.dart';
import 'vues/home.dart';
import 'components/bottom_navigation_bar.dart';
import 'vues/detail_annonce.dart';
import 'model/annonce.dart';
import 'vues/mes_annonces.dart';
import 'vues/inscription_page.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/welcome',
      routes: [
        GoRoute(
          path: '/welcome',
          pageBuilder: (context, state) =>
              const MaterialPage(child: WelcomePage()),
        ),
        GoRoute(
          path: '/connexion',
          pageBuilder: (context, state) =>
              MaterialPage(child: ConnexionPage()),
        ),
        GoRoute(
          path:'/inscription',
          pageBuilder: (context, state) =>
              const MaterialPage(child: InscriptionPage()),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => MaterialPage(
            child: Scaffold(
              body: const HomePage(),
              bottomNavigationBar: BottomNavBar(router),
            ),
          ),
          routes: [
            GoRoute(
              path: 'annonces/:id',
              pageBuilder: (context, state) => MaterialPage(
                child: Scaffold(
                  body: AnnonceDetailsWidget(
                    annonceRef: Annonce(
                      id: 5,
                      name: 'Annonce 5',
                      description: 'Description de l\'annonce 5',
                      image: 'https://picsum.photos/250?image=13',
                      isFavorited: false,
                      dateDebut: DateTime.now(),
                      dateFin: DateTime.now(),
                      categorie: 'Categorie 3',
                    ),
                  ),
                  bottomNavigationBar: BottomNavBar(router),
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/mes-annonces',
          pageBuilder: (context, state) => MaterialPage(
            child: Scaffold(
              body: MesAnnoncesPage(),
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
      ),
    );
  }
}
