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
      await supabase.from('utilisateur').insert(utilisateur.toMap());
    } catch (error) {
      // Gérer l'erreur ici
      print('Erreur lors de l\'ajout de l\'utilisateur: $error');
    }
  }

  // Fonction pour verifier si un utilisateur existe
  userExists(String pseudo, String mdp) async {
    try {
      // On récupère les utilisateurs
      final utilisateurs = supabase.from('utilisateur').select();

      // On vérifie si l'utilisateur existe
      final response = await utilisateurs.eq('pseudo_util', pseudo).eq('mdp_util', mdp);

      return response;
    } catch (error) {
      // Gérer l'erreur ici
      print('Erreur lors de la vérification de l\'existence de l\'utilisateur: $error');
    }
  }

  Stream<Utilisateur> getUser(String pseudo){
    try {
      // On récupère les utilisateurs
      final utilisateurs = supabase.from('utilisateur').select();

      // On récupère l'utilisateur
      final response = utilisateurs.eq('pseudo_Util', pseudo);

      // On retourne l'utilisateur
      return response.asStream().map((reponse) =>
        Utilisateur.fromMap(reponse.first)
      );
    } catch (error) {
      // Gérer l'erreur ici
      print('Erreur lors de la récupération de l\'utilisateur: $error');
      return const Stream.empty();
    }
  }



}