import 'dart:developer';

import 'package:sae_allo_mobile/main.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';

class UserProvider{

  // Fonction pour récupérer les utilisateurs
  Stream<List<Utilisateur>> get users {
    try {
      // La requête pour récupérer les utilisateurs
      final tables = supabase.from('utilisateur').select();

      // On retourne les utilisateurs sous forme de classe Utilisateur
      return tables.asStream().map((reponse) =>
        reponse.map((row) => Utilisateur.fromMap(row)).toList()
      );
    } catch (error) {
      // Gérer l'erreur ici
      print('Erreur lors de la récupération des utilisateurs: $error');
      return const Stream.empty();

    }
  }



  // Fonction pour ajouter un utilisateur
  Future<void> addUser(Utilisateur utilisateur) async {
    try {
      // On ajoute l'utilisateur dans la base de données
      await supabase.from('utilisateur').insert(utilisateur.toInsert());
    } catch (error) {
      // Gérer l'erreur ici
      print('Erreur lors de l\'ajout de l\'utilisateur: $error');
    }
  }

  // Fonction pour verifier si un utilisateur existe
  Future<Utilisateur> userExists(String pseudo, String mdp)  {
    try {
      // On récupère les utilisateurs
      final utilisateurs = supabase.from('utilisateur').select().eq('email_util', pseudo).eq('mdp_util', mdp);

      final utilisateur = utilisateurs.asStream().first.then((value) => Utilisateur.fromMap(value.first));

      return utilisateur ;

    } catch (error) {
      // Gérer l'erreur ici
      log('email: $pseudo');
      log('mdp: $mdp');
      print('Erreur lors de la vérification de l\'existence de l\'utilisateur: $error');
      return Future.value(Utilisateur(id_Util: -1, prenom_Util: "Erreur", nom_Util: "Erreur", pseudo_Util: "Erreur", age: 1, mdp_util: "Erreur", email_Util: "Erreur", telephone: "Erreur"));
    }
  }

   getUser(int idUtil) async {
    Utilisateur nonTrouve = Utilisateur(
      id_Util: 0,
      nom_Util: 'Utilisateur non trouvé',
      prenom_Util: 'Aucun prénom',
      pseudo_Util: 'Aucun pseudo',
      age: 0,
      mdp_util: 'Aucun mot de passe',
      email_Util: 'Aucun email',
      telephone: 'Aucun téléphone',
    );
    try {
      final tables = supabase.from('utilisateur').select().eq('id_util', idUtil);

      if (tables.asStream().first != null) {
        return Utilisateur.fromMap(await tables.then((value) => value.first));
      } else {
        return nonTrouve;
      }

    } catch (error) {
      print('Erreur lors de la récupération de l\'utilisateur: $error');
      return nonTrouve;
    }
  }



}