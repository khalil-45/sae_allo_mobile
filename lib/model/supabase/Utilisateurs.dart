
import 'dart:developer';
class Utilisateur{

  int id_Util;
  String prenom_Util;
  String nom_Util;
  String pseudo_Util;
  int age;
  String mdp_util;
  String email_Util;
  String telephone;

  Utilisateur({
    required this.id_Util,
    required this.prenom_Util,
    required this.nom_Util,
    required this.pseudo_Util,
    this.age = 0,
    required this.mdp_util,
    required this.email_Util,
    required this.telephone,
  });


  Map<String, dynamic> toMap() {
    return {
      'id_util': id_Util,
      'prenom_util': prenom_Util,
      'nom_util': nom_Util,
      'pseudo_util': pseudo_Util,
      'age': age,
    };
  }

    Map<String, dynamic> toInsert() {
    return {
      'prenom_util': prenom_Util,
      'nom_util': nom_Util,
      'pseudo_util': pseudo_Util,
      'age_util': age,
      'mdp_util': mdp_util,
      'email_util': email_Util,
      'telephone': telephone,
    };
    }


  static Utilisateur fromMap(Map<String, dynamic> map) {
    // for (var key in map.keys) {
    //   print('Key: $key  : ${map[key]}' );
    // }
    try {
    return Utilisateur(
      id_Util: map['id_util'],
      prenom_Util: map['prenom_util'],
      nom_Util: map['nom_util'],
      pseudo_Util: map['pseudo_util'],
      age: map['age_util'],
      mdp_util: map['mdp_util'],
      email_Util: map['email_util'],
      telephone: map['telephone'],

    );
    } catch (e) {
      log('Erreur lors de la conversion de la map en Utilisateur: $e');
      return Utilisateur(id_Util: -1, prenom_Util: 'Erreur', nom_Util: 'Erreur', pseudo_Util: 'Erreur', age: 1, mdp_util: 'Erreur', email_Util: 'Erreur', telephone: 'Erreur');
    }
  }

  @override
  String toString() {
    return 'Utilisateur{id_Util: $id_Util, prenom_Util: $prenom_Util, nom_Util: $nom_Util, pseudo_Util: $pseudo_Util, age: $age}';
  }


}