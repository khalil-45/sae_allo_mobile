class Objet{
  int id_Objet;
  String nom_Objet;
  String description_objet;

  Objet({
    required this.id_Objet,
    required this.nom_Objet,
    required this.description_objet,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_Objet': id_Objet,
      'nom_Objet': nom_Objet,
      'description_objet': description_objet,
    };
  }

  factory Objet.fromMap(Map<String, dynamic> map) {
    return Objet(
      id_Objet: map['id_Objet'],
      nom_Objet: map['nom_Objet'],
      description_objet: map['description_objet'],
    );
  }

  Map<String, dynamic> toInsert() {
    return {
      'nom_Objet': nom_Objet,
      'description_objet': description_objet,
    };
  }

  

}