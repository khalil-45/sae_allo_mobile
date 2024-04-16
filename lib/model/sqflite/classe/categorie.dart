class CatObjet{
  int id;
  String nom;
  String description;

  CatObjet({required this.id, required this.nom, required this.description});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nom': nom,
      'description_Cat': description,
    };
  }

  static CatObjet fromMap(Map<String, dynamic> map){
    return CatObjet(
      id: map['id'],
      nom: map['nom'],
      description: map['description_Cat'],
    );
  }

  Map<String, dynamic> toInsert(){
    return {
      'nom': nom,
      'description_Cat': description,
    };
  }
}