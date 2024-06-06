import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sae_allo_mobile/components/buttons.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
import 'package:sae_allo_mobile/model/sqflite/providers/objetProv.dart';
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
  late Annonce annoncePrete;
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

  affichePop(int idCategorie) {
    final Future<List<ObjetLocale>> obj = ObjetProv().getObjetByCat(idCategorie);
    log("ID de la catégorie: $idCategorie");
    int _idObjet = 0; // Variable pour stocker l'ID de l'objet sélectionné
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sélectionnez un objet'),
          content: FutureBuilder<List<ObjetLocale>>(
            future: obj,
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
                return snapshot.data!.isEmpty
                    ? const Center(
                        child: Text('Aucune donnée'),
                      )
                    : DropdownButtonFormField<int>(
                        items: snapshot.data!.map((objet) {
                          return DropdownMenuItem<int>(
                            value: objet.id_Objet,
                            child: Text(objet.nom_Objet),
                          );
                        }).toList(),
                        onChanged: (value) => _idObjet = value!,
                      );
              } else {
                return Column(
                  children: [
                    const Text('Aucune donnée'),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint("ID de l'objet sélectionné: $_idObjet");
                        Navigator.of(context).pop();
                      },
                      child: const Text('Valider'),
                    ),
                  ],
                );
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                log("ID de l'objet sélectionné: $_idObjet");

               if (_idObjet != 0 && annoncePrete.idEtat == 1) {
                  log('Objet va être prêté');
                  ObjetProv().pretObjet(_idObjet, annoncePrete);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Objet prêté'),
                    ),
                  );
                  context.go('/home');
                } else {
                  if (annoncePrete.idEtat != 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Annonce déjà prise'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez sélectionner un objet'),
                      ),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
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
          annoncePrete = annonceData;
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
                            annonceData.image                          ),
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
                          Column(
                            children: [
                              Row(
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
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Etat: ${annonceData.idEtat == 1 ? 'Disponible' : 'Pris'}',
                                    style: const  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ],
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
                          Center(child: buttonAider(context,function: affichePop,idCat: annonceData.idCategorie)),
                        
                        ]
                        
                      ),
                    )
                  ]
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