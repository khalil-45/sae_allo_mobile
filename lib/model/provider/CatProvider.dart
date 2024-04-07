
import 'package:sae_allo_mobile/main.dart';
import 'package:sae_allo_mobile/model/Categorie.dart';




class cat_Provider{

  Stream<List<Categorie>> get categories {
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


  catExists(String nom) async {
    try {
      final categories = supabase.from('categorie').select();

      final response = await categories.eq('nom_Cat', nom);

      return response.isNotEmpty;
    } catch (error) {
      print('Erreur lors de la vérification de l\'existence de la catégorie: $error');
    }
  }

}