
import 'package:sae_allo_mobile/main.dart';
import 'package:sae_allo_mobile/model/supabase/Categorie.dart';




class CatProvider{

  Stream<List<Categorie>>  categories() {
    try {
      final tables = supabase.from('categorie').select();

      return tables.asStream().map((reponse) =>
        reponse.map((row) => Categorie.fromMap(row)).toList()
      );
    } catch (error) {
      print('Erreur lors de la récupération des catégories: $error');
      return const Stream.empty();
    }
  }



  Future<void> addCategorie(Categorie categorie) async {
    try {
      await supabase.from('categorie').insert(categorie.toMap());
    } catch (error) {
      print('Erreur lors de l\'ajout de la catégorie: $error');
    }
  }

  Stream<List<Categorie>> getCategorie(int idCat) {
    Categorie nonTrouve = Categorie(
      id_Cat: 0,
      nom_Cat: 'Catégorie non trouvée',
    );
    try {
      final tables = supabase.from('categorie').select().eq('id_cat', idCat);

       return tables.asStream().map((reponse) =>
        reponse.map((row) => Categorie.fromMap(row)).toList()
      );


    } catch (error) {

      print('Categorie non trouvée');
      return Stream.value([nonTrouve]);

    
    } 


}

}