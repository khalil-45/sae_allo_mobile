import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/const.dart';
import 'package:sae_allo_mobile/model/supabase/Annonce.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/model/supabase/provider/annonceProv.dart';

class MesAnnoncesPage extends StatefulWidget {
  @override
  _MesAnnoncesPageState createState() => _MesAnnoncesPageState();
}

class _MesAnnoncesPageState extends State<MesAnnoncesPage> {
  late Stream<List<Annonce>> mesAnnoncesStream;
  late final int id_Util;

  @override
  void initState() {
    super.initState();
    fetchMesAnnonces();
  }

  void fetchMesAnnonces() async {
    id_Util = user.id_Util;
    mesAnnoncesStream = AnnonceProv().annoncesByUser(id_Util);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Annonces'),
      ),
      body: StreamBuilder<List<Annonce>>(
        stream: mesAnnoncesStream,
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            log('Erreur lors de la récupération des annonces: ${snapshot.error}');
            return const Center(
              child: Text('Erreur lors de la récupération des annonces'),
            );
          }

          final annonces = snapshot.data!;

          if (annonces.isEmpty) {
            return const Center(
              child: Text('Aucune annonce trouvée'),
            );
          }

          return ListView.builder(
            itemCount: annonces.length,
            itemBuilder: (context, index) {
              final annonce = annonces[index];
              return Card(  
                child: ListTile(
                  title: Text(annonce.titreAnnonce),
                    subtitle: Text('${annonce.descriptionAnnonce.substring(0, annonce.descriptionAnnonce.length > 15 ? 15 : annonce.descriptionAnnonce.length)}...'),
                  onTap: () {
                    context.go('/home/annonces/${annonce.idAnnonce}');
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/home/annonces/add');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}


