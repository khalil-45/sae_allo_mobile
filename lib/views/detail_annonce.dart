import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/components/buttons.dart';
import 'package:sae_allo_mobile/model/Categorie.dart';
import '../model/Annonce.dart';
import 'package:sae_allo_mobile/model/provider/annonceProv.dart';
import 'package:sae_allo_mobile/model/provider/CatProvider.dart';

class AnnonceDetailsWidget extends StatefulWidget {
  AnnonceDetailsWidget({
    Key? key,
    required this.idAnnonce,
  }) : super(key: key);

  int idAnnonce;

  @override
  State<AnnonceDetailsWidget> createState() => _AnnonceDetailsWidgetState();
}

class _AnnonceDetailsWidgetState extends State<AnnonceDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final annonceRef;
  late final categorie;


  @override
  void initState() {
    super.initState();
    _fetchAnnonce();
  }

  void _fetchAnnonce() async {
    annonceRef = await AnnonceProv().getAnnonce(widget.idAnnonce);
    final categorie = await CatProvider().getCategorie(annonceRef.idCategorie);
    if (annonceRef != null) {
      log('Cest bon');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Annonce non trouvée'),
        ),
      );
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    key: scaffoldKey,
    backgroundColor: Theme.of(context).primaryColor,
    body: FutureBuilder(
      future: annonceRef,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
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
                      annonceRef.image ??
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
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      annonceRef.titreAnnonce,
                      style: const TextStyle(
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      annonceRef.descriptionAnnonce,
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        annonceRef.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        setState(() {
                          annonceRef.isFavorited = !annonceRef.isFavorited;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Categorie: ${categorie.nom_Etat}',
                              style: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Date de debut: ${annonceRef.dateAnnonce}',
                              style: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Date de fin : ${annonceRef.dateFinAnnonce}',
                              style: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(child: buttonAider(context)),
                  ],
                ),
              ),
            ],
          );
        }
      },
    ),
  );
}

}
