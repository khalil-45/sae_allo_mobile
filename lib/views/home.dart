import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sae_allo_mobile/components/annonce_card.dart';
import 'package:sae_allo_mobile/model/Categorie.dart';
import 'package:sae_allo_mobile/model/Etat.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';
import '../components/empty_state_widget.dart';
import '../model/Annonce.dart';
import 'package:sae_allo_mobile/model/provider/annonceProv.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Stream<List<Annonce>> _future;

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      HapticFeedback.mediumImpact();
    });
    _future = AnnonceProv().annonces();
  }

  @override
  Widget build(BuildContext context) {
    Annonce annonce1 = Annonce(
      idAnnonce: 1,
      titreAnnonce: 'Annonce 1',
      descriptionAnnonce: 'Description de l\'annonce 1',
      image: 'https://picsum.photos/250?image=9',
      isFavorited: false,
      dateAnnonce: DateTime.now(),
      dateFinAnnonce: DateTime.now(),
      categorie: Categorie(id_Cat: 1, nom_Cat: 'Categorie 1'),
      idUtilPreneur: 1,
      utilPublieur: Utilisateur(id_Util: 1, nom_Util: 'Utilisateur 1', prenom_Util: 'Prenom 1', pseudo_Util: 'Pseudo 1' , age: 10),
      etat: Etat(id_Etat: 1, nom_Etat: 'En cours'),
    );
    Annonce annonce2 = Annonce(
      idAnnonce: 2,
      titreAnnonce: 'Annonce 2',
      descriptionAnnonce: 'Description de l\'annonce 2',
      image: 'https://picsum.photos/250?image=10',
      isFavorited: false,
      dateAnnonce: DateTime.now(),
      dateFinAnnonce: DateTime.now(),
      categorie: Categorie(id_Cat: 1, nom_Cat: 'Categorie 1'),
      idUtilPreneur: 1,
      utilPublieur: Utilisateur(id_Util: 1, nom_Util: 'Utilisateur 1', prenom_Util: 'Prenom 1', pseudo_Util: 'Pseudo 1' , age: 10),
      etat: Etat(id_Etat: 1, nom_Etat: 'En cours'),
    );
    Annonce annonce3 = Annonce(
      idAnnonce: 3,
      titreAnnonce: 'Annonce 3',
      descriptionAnnonce: 'Description de l\'annonce 3',
      image: 'https://picsum.photos/250?image=11',
      isFavorited: false,
      dateAnnonce: DateTime.now(),
      dateFinAnnonce: DateTime.now(),
      categorie: Categorie(id_Cat: 1, nom_Cat: 'Categorie 1'),
      idUtilPreneur: 1,
      utilPublieur: Utilisateur(id_Util: 1, nom_Util: 'Utilisateur 1', prenom_Util: 'Prenom 1', pseudo_Util: 'Pseudo 1' , age: 10),
      etat: Etat(id_Etat: 1, nom_Etat: 'En cours'),
    );
    Annonce annonce4 = Annonce(
      idAnnonce: 4,
      titreAnnonce: 'Annonce 4',
      descriptionAnnonce: 'Description de l\'annonce 4',
      image: 'https://picsum.photos/250?image=12',
      isFavorited: false,
      dateAnnonce: DateTime.now(),
      dateFinAnnonce: DateTime.now(),
      categorie: Categorie(id_Cat: 1, nom_Cat: 'Categorie 1'),
      idUtilPreneur: 1,
      utilPublieur: Utilisateur(id_Util: 1, nom_Util: 'Utilisateur 1', prenom_Util: 'Prenom 1', pseudo_Util: 'Pseudo 1' , age: 10),
      etat: Etat(id_Etat: 1, nom_Etat: 'En cours'),
    );
    Annonce annonce5 = Annonce(
      idAnnonce: 5,
      titreAnnonce: 'Annonce 5',
      descriptionAnnonce: 'Description de l\'annonce 5',
      image: 'https://picsum.photos/250?image=13',
      isFavorited: false,
      dateAnnonce: DateTime.now(),
      dateFinAnnonce: DateTime.now(),
      categorie: Categorie(id_Cat: 1, nom_Cat: 'Categorie 1'),
      idUtilPreneur: 1,
      utilPublieur: Utilisateur(id_Util: 1, nom_Util: 'Utilisateur 1', prenom_Util: 'Prenom 1', pseudo_Util: 'Pseudo 1' , age: 10),
      etat: Etat(id_Etat: 1, nom_Etat: 'En cours'),
    );
    var gridViewMealsRecordList = [
      annonce1,
      annonce2,
      annonce3,
      annonce4,
      annonce5,];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This week\'s meals',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                      child: Text(
                        'Made to order with fresh ingredients each week.',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: StreamBuilder<List<Annonce>>(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final gridViewMealsRecordList = snapshot.data!;
                        return gridViewMealsRecordList.isEmpty
                            ? EmptyStateWidget(
                                icon: Icon(
                                  Icons.no_food_outlined,
                                  color: Theme.of(context).colorScheme.onBackground,
                                  size: 64,
                                ),
                                title: 'No Meals',
                                description:
                                    'No meals have been created or match your dietary preferences.',
                              )
                            : GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.78,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: gridViewMealsRecordList.length,
                                itemBuilder: (context, gridViewIndex) {
                                  final gridViewAnnonceRecord =
                                      gridViewMealsRecordList[gridViewIndex];
                                  return AnnonceCardWidget(
                                    key: Key(
                                        'Keykia_${gridViewIndex}_of_${gridViewMealsRecordList.length}'),
                                    annonceRef: gridViewAnnonceRecord,
                                  );
                                },
                              );
                      }
                    }, stream: _future,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}