import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/views/addAnnonce.dart';
import 'package:sae_allo_mobile/views/connexion_page.dart';
import 'package:sae_allo_mobile/views/detail_annonce.dart';
import 'package:sae_allo_mobile/views/home.dart';
import 'package:sae_allo_mobile/views/inscription_page.dart';
import 'package:sae_allo_mobile/views/mes_annonces.dart';
import 'package:sae_allo_mobile/views/welcome.dart';
import 'components/bottom_navigation_bar.dart';
import 'package:sae_allo_mobile/views/profil.dart';
import 'package:sae_allo_mobile/views/addobjet.dart';
import 'package:sae_allo_mobile/views/objet_dertail.dart';


final GlobalKey<NavigatorState> _goRouterKey = GlobalKey<NavigatorState>();

class AppRouter {
  late final GoRouter _router;

  AppRouter() {
    _router = GoRouter(
      initialLocation: '/',
      navigatorKey: _goRouterKey,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const WelcomePage();
          },
        ),
        GoRoute(
          path: '/sign',
          builder: (context, state) {
            return ConnexionPage();
          },
          routes: [
            GoRoute(
              path: 'up',
              builder: (context, state) {
                return const InscriptionPage();
              },
            ),
          ]
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const MaterialPage(
            child: Scaffold(
              body: HomePage(),
              bottomNavigationBar: BottomNavBar(),
            ),
          ),
          routes: [
            GoRoute(
              path: 'profil',
              pageBuilder: (context, state) => const MaterialPage(
                child: Scaffold(
                  body: profil(),
                  bottomNavigationBar: BottomNavBar(),
                ),
              ),
            ),
            GoRoute(
              path: 'objet',
              pageBuilder: (context, state) => const MaterialPage(
                child: Scaffold(
                  body: HomePage(),
                  bottomNavigationBar: BottomNavBar(),
                ),
              ),
              routes: [
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id'];
                    if (id != null && int.tryParse(id) != null) {
                      return MaterialPage(
                        child: Scaffold(
                          body: ObjetDetailsWidget(
                            idObjet: int.parse(id),
                          ),
                          bottomNavigationBar: BottomNavBar(),
                        ),
                      );
                    } else {
                      return MaterialPage(
                        child: Scaffold(
                          body: AddObjetPage(),
                          bottomNavigationBar: BottomNavBar(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'annonces',
              pageBuilder: (context, state) => MaterialPage(
                child: Scaffold(
                  body: MesAnnoncesPage(),
                  bottomNavigationBar: BottomNavBar(),
                ),
              ),
              routes: [
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id'];
                    if (id != null && int.tryParse(id) != null) {
                      return MaterialPage(
                        child: Scaffold(
                          body: AnnonceDetailsWidget(
                            idAnnonce: int.parse(id),
                          ),
                          bottomNavigationBar: BottomNavBar(),
                        ),
                      );
                    } else {
                      return MaterialPage(
                        child: Scaffold(
                          body: AddAnnoncesPage(),
                          bottomNavigationBar: BottomNavBar(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/mes-annonces',
          parentNavigatorKey: _goRouterKey,
          pageBuilder: (context, state) => MaterialPage(
            child: Scaffold(
              body: MesAnnoncesPage(),
              bottomNavigationBar: BottomNavBar(),
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
                const Text('Page non trouvée !'),
                TextButton(
                  child: const Text('Aller à la page d\'accueil'),
                  onPressed: () => _router.go('/home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GoRouter get router => _router;
}
