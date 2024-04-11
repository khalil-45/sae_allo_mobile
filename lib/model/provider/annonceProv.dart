import 'package:sae_allo_mobile/main.dart';
import 'package:sae_allo_mobile/model/Annonce.dart';
import 'package:sae_allo_mobile/model/Categorie.dart';
import 'package:sae_allo_mobile/model/Etat.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnnonceProv {



  Stream<List<Annonce>> annonces() {
    try {
      final tables = supabase.from('annonce').select();

      return tables.asStream().map((reponse) =>
        reponse.map((row) => Annonce.fromMap(row)).toList()
      );
    } catch (error) {
      print('Erreur lors de la récupération des annonces: $error');
      return const Stream.empty();
    }
  }


  Stream<List<Annonce>> getAnnonce(int idAnnonce) {
    Annonce nonTrouve = Annonce(
      idAnnonce: 0,
      titreAnnonce: 'Annonce non trouvée',
      descriptionAnnonce: 'Aucune annonce trouvée',
      image: 'https://picsum.photos/250?image=1',
      isFavorited: false,
      dateAnnonce: DateTime.now(),
      dateFinAnnonce: DateTime.now(),
      idCategorie: 0,
      idUtilPreneur: 0,
      idUtilPublieur: 0,
      idEtat: 0,
    );
    try {
      final tables = supabase.from('annonce').select().eq('id_annonce', idAnnonce);

       return tables.asStream().map((reponse) =>
        reponse.map((row) => Annonce.fromMap(row)).toList()
      );

    } catch (error) {
      print('Erreur lors de la récupération de l\'annonce: $error');
      return Stream.value([nonTrouve]);
    }
  }

}