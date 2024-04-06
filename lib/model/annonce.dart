class Annonce{
  int id;
  String name;
  String image;
  DateTime dateDebut;
  DateTime dateFin;
  bool isFavorited;
  String categorie;
  String description;

  Annonce({required this.name, required this.image, required this.isFavorited, required this.id, required this.dateDebut, required this.dateFin, required this.categorie, required this.description});


}