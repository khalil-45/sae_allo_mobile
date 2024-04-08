import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/views/home.dart';
import 'views/connexion_page.dart';
import 'views/welcome.dart';
import 'components/bottom_navigation_bar.dart';
import 'views/detail_annonce.dart';
import 'views/mes_annonces.dart';
import 'views/inscription_page.dart';

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
          return ConnexionPage();
        },
      ),
      GoRoute(
        path: '/inscription',
        builder: (context, state) {
          return const InscriptionPage();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomePage();
        },
        routes: [GoRoute(
              path: 'annonces/:id',
              parentNavigatorKey: _goRouterKey,
              pageBuilder: (context, state) => MaterialPage(
                child: Scaffold(
                  body: AnnonceDetailsWidget(
                    idAnnonce: int.parse(state.pathParameters['id']!),
                  ),
                  bottomNavigationBar: BottomNavBar(router),
                ),
              ),
            ),
          GoRoute(
            path: '/mes-annonces',
            parentNavigatorKey: _goRouterKey,
            pageBuilder: (context, state) => MaterialPage(
              child: Scaffold(
                body: MesAnnoncesPage(),
                bottomNavigationBar: BottomNavBar(router),
              ),
            ),
          ),
        ]
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

