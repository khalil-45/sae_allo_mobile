import 'package:sae_allo_mobile/main.dart';
import 'package:sae_allo_mobile/model/Annonce.dart';

class AnnonceProv {



  Stream<List<Annonce>> get annonces {
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


}