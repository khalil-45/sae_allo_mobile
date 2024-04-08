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

  static Etat fromMap(Map<String,dynamic> map) {
    print('Map: $map : ${map.runtimeType}');
    try {
      return Etat(
        id_Etat: map['id_etat'],
        nom_Etat: map['nom_etat'],
      );
    } catch (e) {
      // Handle the exception here
      print('Error while creating Etat object: $e');
      return Etat(id_Etat: 0, nom_Etat: 'Error');
    }
  }

  @override
  String toString() {
    return 'Etat{id_etat: $id_Etat, nom_etat: $nom_Etat}';
  }

}