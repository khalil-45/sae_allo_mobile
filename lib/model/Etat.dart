class Etat{
  int id_Etat;
  String nom_Etat;

  Etat({
    required this.id_Etat,
    required this.nom_Etat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_etat': id_Etat,
      'nom_etat': nom_Etat,
    };
  }

  Map<String, dynamic> toInsert() {
    return {
      'nom_etat': nom_Etat,
    };
  }

  static Etat fromMap(Map<String, dynamic> map) {
    return Etat(
      id_Etat: map['id_etat'],
      nom_Etat: map['nom_etat'],
    );
  }

  @override
  String toString() {
    return 'Etat{id_etat: $id_Etat, nom_etat: $nom_Etat}';
  }

}