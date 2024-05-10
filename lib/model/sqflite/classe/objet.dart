class ObjetLocale{
  int id_Objet;
  String nom_Objet;
  String description_objet;
  String image_objet;
  bool isFavorited = false;
  int id_Cat;
  int id_Annonce = 0;

  ObjetLocale({
    required this.id_Objet,
    required this.nom_Objet,
    required this.description_objet,
    required this.image_objet,
    required this.id_Cat,
  });

  ObjetLocale.withAnnonce({
    required this.id_Objet,
    required this.nom_Objet,
    required this.description_objet,
    required this.image_objet,
    required this.id_Cat,
    required this.id_Annonce,
  });

  String get image => image_objet == null || image_objet.trim() == '' ? 'https://picsum.photos/200/300?random=1' : image_objet;

  Map<String, dynamic> toMap() {
    return {
      'id_Objet': id_Objet,
      'nom_Objet': nom_Objet,
      'description_objet': description_objet,
    };
  }

  factory ObjetLocale.fromMap(Map<String, dynamic> map) {
    return ObjetLocale.withAnnonce(
      id_Objet: map['id_Objet'],
      nom_Objet: map['nom_Objet'],
      description_objet: map['description_objet'],
      image_objet: map['image_objet'] ?? 'https://picsum.photos/200/300?random=1',
      id_Cat: map['id_Cat'],
      id_Annonce: map['id_Annonce'] ?? 0,
    );
  }

  Map<String, dynamic> toInsert() {
    return {
      'nom_Objet': nom_Objet,
      'description_objet': description_objet,
      'image_objet': image_objet,
      'id_Cat': id_Cat,
    };
  }

  

}