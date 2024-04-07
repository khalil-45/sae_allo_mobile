
import 'package:supabase_flutter/supabase_flutter.dart';

class Utilisateur{

  int id_Util;
  String prenom_Util;
  String nom_Util;
  String pseudo_Util;
  int age;

  Utilisateur({
    required this.id_Util,
    required this.prenom_Util,
    required this.nom_Util,
    required this.pseudo_Util,
    required this.age,
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
      'age': age,
    };
    }


  static Utilisateur fromMap(Map<String, dynamic> map) {
    // for (var key in map.keys) {
    //   print('Key: $key');
    // }
    return Utilisateur(
      id_Util: map['id_util'],
      prenom_Util: map['prenom_util'],
      nom_Util: map['nom_util'],
      pseudo_Util: map['pseudo_util'],
      age: map['age_util'],
    );
  }

  @override
  String toString() {
    return 'Utilisateur{id_Util: $id_Util, prenom_Util: $prenom_Util, nom_Util: $nom_Util, pseudo_Util: $pseudo_Util, age: $age}';
  }


}