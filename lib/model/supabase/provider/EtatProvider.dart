

import 'package:sae_allo_mobile/main.dart';
import 'package:sae_allo_mobile/model/supabase/Etat.dart';

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

  Future<Etat> getEtat(int idEtat) async {
    Etat nonTrouve = Etat(
      id_Etat: 0,
      nom_Etat: 'Etat non trouvé',
    );
    try {
      final tables = supabase.from('etat').select().eq('id_etat', idEtat);

      final etat = await tables.then((value) => Etat.fromMap(value.first));

      if (tables.asStream().first != null) {
        return etat;
      } else {
        return nonTrouve;
      }

    } catch (error) {
      print('Erreur lors de la récupération de l\'etat: $error');
      return nonTrouve;
    }
  }




}