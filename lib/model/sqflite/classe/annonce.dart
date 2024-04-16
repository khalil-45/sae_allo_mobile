class AnnonceLoc{
  final int idAnnonce;
  final String titreAnnonce;
  final String descriptionAnnonce;

  AnnonceLoc({
    required this.idAnnonce,
    required this.titreAnnonce,
    required this.descriptionAnnonce,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_Annonce': idAnnonce,
      'titreAnnonce': titreAnnonce,
      'descriptionAnnonce': descriptionAnnonce,
    };
  }

  factory AnnonceLoc.fromMap(Map<String, dynamic> map) {
    return AnnonceLoc(
      idAnnonce: map['id_Annonce'],
      titreAnnonce: map['titreAnnonce'],
      descriptionAnnonce: map['descriptionAnnonce'],
    );
  }
}