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

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      dateDebut: DateTime.parse(json['dateDebut']),
      dateFin: DateTime.parse(json['dateFin']),
      isFavorited: json['isFavorited'],
      categorie: json['categorie'],
      description: json['description'],
    );
  }
}