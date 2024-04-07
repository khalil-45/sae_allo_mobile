class Categorie{

  int id_Cat;
  String nom_Cat;

  Categorie({
    required this.id_Cat,
    required this.nom_Cat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_cat': id_Cat,
      'nom_cat': nom_Cat,
    };
  }

    Map<String, dynamic> toInsert() {
    return {
      'nom_cat': nom_Cat,
    };
    }


  static Categorie fromMap(Map<String, dynamic> map) {
    return Categorie(
      id_Cat: map['id_cat'],
      nom_Cat: map['nom_cat'],
    );
  }

  @override
  String toString() {
    return 'Categorie{id_Cat: $id_Cat, nom_Cat: $nom_Cat}';
  }
}