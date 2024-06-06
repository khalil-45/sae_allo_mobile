
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/components/buttons.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
import 'package:sae_allo_mobile/model/sqflite/providers/objetProv.dart';

class ObjetDetailsWidget extends StatefulWidget {
  ObjetDetailsWidget({
    Key? key,
    required this.idObjet,
  }) : super(key: key);

  final int idObjet;

  @override
  State<ObjetDetailsWidget> createState() => _ObjetDetailsWidgetState();
}

class _ObjetDetailsWidgetState extends State<ObjetDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<ObjetLocale> objet;
  late bool estPret;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      HapticFeedback.mediumImpact();
    });
    _fetchObjet();
  }

  void _fetchObjet() {
    objet = ObjetProv().getObjet(widget.idObjet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder<ObjetLocale>(
        future: objet,
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
            final objetData = snapshot.data!;
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
                        objetData.image_objet.trim() == '' || objetData.image_objet.trim() == ' '
                            ? 'https://picsum.photos/200/300?random=1'
                            : objetData.image_objet
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
                    children: [Row(
                      children: [
                        Text(
                          objetData.nom_Objet,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            objetData.isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            setState(() {
                              objetData.isFavorited = !objetData.isFavorited;
                            });
                          },
                        ),],
                    ),
                      FutureBuilder(future: ObjetProv().objetEstPreter(objetData.id_Objet)
                        , builder:
                          (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Erreur: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          estPret = snapshot.data?['estPreter'] ?? false;
                          int idAnnonce = snapshot.data?['id_Annonce'] ?? 0;
                          log(snapshot.data.toString());
                          return ListTile(
                            title: Text('Objet prêté: ${estPret ? 'Oui' : 'Non'}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: estPret ? Colors.green : Colors.red,
                              ),
                            ),
                            onTap: () => {
                              if (estPret && idAnnonce != 0)
                                {
                                context.go('/home/annonces/$idAnnonce')
                                }
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('Aucune donnée'),
                          );
                        }
                      },
                      ),

                      const SizedBox(height: 20),
                      Center(child: buttonProposer(context)),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Aucune donnée'),
            );
          }
        },
      ),
    );
  }
}
