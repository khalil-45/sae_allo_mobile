
import 'package:supabase_flutter/supabase_flutter.dart';

class Utilisateur{

  final String id_Util;
  final String prenom_Util;
  final String nom_Util;
  final String pseudo_Util;
  final int age;

  Utilisateur({
    required this.id_Util,
    required this.prenom_Util,
    required this.nom_Util,
    required this.pseudo_Util,
    required this.age,
  });


  Map<String, dynamic> toMap() {
    return {
      'id_Util': id_Util,
      'prenom_Util': prenom_Util,
      'nom_Util': nom_Util,
      'pseudo_Util': pseudo_Util,
      'age': age,
    };
  }

  static Utilisateur fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      id_Util: map['id_Util'],
      prenom_Util: map['prenom_Util'],
      nom_Util: map['nom_Util'],
      pseudo_Util: map['pseudo_Util'],
      age: map['age'],
    );
  }

  @override
  String toString() {
    return 'Utilisateur{id_Util: $id_Util, prenom_Util: $prenom_Util, nom_Util: $nom_Util, pseudo_Util: $pseudo_Util, age: $age}';
  }


}