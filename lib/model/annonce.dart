class Annonce {
  int id;
  String name;
  String image;
  DateTime dateDebut;
  DateTime dateFin;
  bool isFavorited;
  int categorie;
  String description;
  // Add the new fields here
  int idEtat;
  int idUtilPub;
  int idUtilRep;

  Annonce(
      {required this.name,
      required this.image,
      required this.isFavorited,
      required this.id,
      required this.dateDebut,
      required this.dateFin,
      required this.categorie,
      required this.description,
      required this.idEtat,
      required this.idUtilPub,
      required this.idUtilRep});

  factory Annonce.fromJson(Map<String, dynamic> json) {
  return Annonce(
    id: json['id_annonce'] as int? ?? 0,
    name: json['titre_annonce'] as String? ?? '',
    image: json['image'] as String? ?? '',
    dateDebut: DateTime.parse(json['date_debut'] as String? ?? '1970-01-01'),
    dateFin: DateTime.parse(json['date_fin'] as String? ?? '1970-01-01'),
    categorie: json['id_cat'] as int? ?? 0,
    description: json['description'] as String? ?? '',
    idEtat: json['id_etat'] as int? ?? 0,
    idUtilPub: json['id_util_pub'] as int? ?? 0,
    idUtilRep: json['id_util_rep'] as int? ?? 0,
    isFavorited: false,
  );
}
}
