class ObjetLocale{
  int id_Objet;
  String nom_Objet;
  String description_objet;
  String image_objet;
  bool isFavorited = false;

  ObjetLocale({
    required this.id_Objet,
    required this.nom_Objet,
    required this.description_objet,
    required this.image_objet,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_Objet': id_Objet,
      'nom_Objet': nom_Objet,
      'description_objet': description_objet,
    };
  }

  factory ObjetLocale.fromMap(Map<String, dynamic> map) {
    return ObjetLocale(
      id_Objet: map['id_Objet'],
      nom_Objet: map['nom_Objet'],
      description_objet: map['description_objet'],
      image_objet: map['image_objet'] ?? 'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    );
  }

  Map<String, dynamic> toInsert() {
    return {
      'nom_Objet': nom_Objet,
      'description_objet': description_objet,
      'image_objet': image_objet,
    };
  }

  

}