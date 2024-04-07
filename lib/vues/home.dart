import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sae_allo_mobile/components/annonce_card.dart';
import '../components/empty_state_widget.dart';
import '../model/annonce.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      HapticFeedback.mediumImpact();
    });
  }

  @override
  Widget build(BuildContext context) {
    Annonce annonce1 = Annonce(
      id: 1,
      name: 'Annonce 1',
      description: 'Description de l\'annonce 1',
      image: 'https://picsum.photos/250?image=9',
      isFavorited: false,
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      categorie: 'Categorie 1',
    );
    Annonce annonce2 = Annonce(
      id: 2,
      name: 'Annonce 2',
      description: 'Description de l\'annonce 2',
      image: 'https://picsum.photos/250?image=10',
      isFavorited: false,
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      categorie: 'Categorie 2',
    );
    Annonce annonce3 = Annonce(
      id: 3,
      name: 'Annonce 3',
      description: 'Description de l\'annonce 3',
      image: 'https://picsum.photos/250?image=11',
      isFavorited: false,
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      categorie: 'Categorie 3',
    );
    Annonce annonce4 = Annonce(
      id: 4,
      name: 'Annonce 4',
      description: 'Description de l\'annonce 4',
      image: 'https://picsum.photos/250?image=12',
      isFavorited: false,
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      categorie: 'Categorie 2',
    );
    Annonce annonce5 = Annonce(
      id: 5,
      name: 'Annonce 5',
      description: 'Description de l\'annonce 5',
      image: 'https://picsum.photos/250?image=13',
      isFavorited: false,
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      categorie: 'Categorie 3',
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
                  child: gridViewMealsRecordList.isEmpty
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
