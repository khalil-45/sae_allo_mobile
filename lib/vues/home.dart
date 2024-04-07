import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sae_allo_mobile/components/annonce_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/empty_state_widget.dart';
import '../model/annonce.dart';
import 'package:supabase/supabase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Annonce>> _future;

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      HapticFeedback.mediumImpact();
    });
    _future = _fetchAnnonces();
  }

  Future<List<Annonce>> _fetchAnnonces() async {
    final response = await Supabase.instance.client
      .from('annonce')
      .select();

    return (response as List).map((json) => Annonce.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: FutureBuilder<List<Annonce>>(
                    future: _future,
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