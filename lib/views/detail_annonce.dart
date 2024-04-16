import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sae_allo_mobile/components/buttons.dart';
import 'package:sae_allo_mobile/model/supabase/Categorie.dart';
import '../model/supabase/Annonce.dart';
import 'package:sae_allo_mobile/model/supabase/provider/annonceProv.dart';
import 'package:sae_allo_mobile/model/supabase/provider/CatProvider.dart';

class AnnonceDetailsWidget extends StatefulWidget {
  AnnonceDetailsWidget({
    Key? key,
    required this.idAnnonce,
  }) : super(key: key);

  final int idAnnonce;

  @override
  State<AnnonceDetailsWidget> createState() => _AnnonceDetailsWidgetState();
}

class _AnnonceDetailsWidgetState extends State<AnnonceDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late var annonce;
  late var categorie;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      HapticFeedback.mediumImpact();
    });
    _fetchAnnonce();
  }

  void _fetchAnnonce() {
    annonce = AnnonceProv().getAnnonce(widget.idAnnonce);
    
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    key: scaffoldKey,
    backgroundColor: Theme.of(context).primaryColor,
    body: StreamBuilder<List<Annonce>>(
      stream: annonce,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erreur: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final annonceData = snapshot.data![0];
          return StreamBuilder<List<Categorie>>(
            stream: CatProvider().getCategorie(annonceData.idCategorie),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Erreur: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final categorieData = snapshot.data![0];
                return ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 450,
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            annonceData.image ??
                                'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            annonceData.titreAnnonce,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            annonceData.descriptionAnnonce,
                            style: const  TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              annonceData.isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            onPressed: () {
                              setState(() {
                                annonceData.isFavorited = !annonceData.isFavorited;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Categorie: ${categorieData.nom_Cat}',
                                  style: const  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Date de debut: ${annonceData.dateAnnonce}',
                                  style: const  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Date de fin : ${annonceData.dateFinAnnonce}',
                                  style: const  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(child: buttonAider(context)),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child:  Text('Aucune donnée'),
                );
              }
            },
          );
        } else {
          return const  Center(
            child: Text('Aucune donnée'),
          );
        }
      },
    ),
  );
}


}