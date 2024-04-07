

import 'package:sae_allo_mobile/main.dart';
import 'package:sae_allo_mobile/model/Etat.dart';

class EtatProvider{


  Stream<List<Etat>> getEtats() {
    try {
      final tables = supabase.from('etat').select();

      return tables.asStream().map((reponse) =>
        reponse.map((row) => Etat.fromMap(row)).toList()
      );
    } catch (error) {
      print('Erreur lors de la récupération des etats: $error');
      return const Stream.empty();
    }
  }

  Future<void> addEtat(Etat etat) async {
    try {
      await supabase.from('etat').insert(etat.toMap());
    } catch (error) {
      print('Erreur lors de l\'ajout de l\'etat: $error');
    }
  }

  getEtat(String nom_Etat) async {
    try {
      final etats = supabase.from('etat').select();

      final response = await etats.eq('nom_etat', nom_Etat);

      return Etat.fromMap(response.first);

    } catch (error) {
      print('Erreur lors de la récupération de l\'etat: $error');
      return Etat(id_Etat: -1, nom_Etat: 'Erreur');
    }
  }




}