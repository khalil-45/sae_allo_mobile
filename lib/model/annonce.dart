import 'package:sae_allo_mobile/model/Categorie.dart';
import 'package:sae_allo_mobile/model/Etat.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';
import 'package:sae_allo_mobile/model/provider/CatProvider.dart';
import 'package:sae_allo_mobile/model/provider/EtatProvider.dart';
import 'package:sae_allo_mobile/model/provider/UserProvider.dart';


class Annonce {

  final int idAnnonce;
  final Utilisateur utilPublieur;
  String titreAnnonce;
  String descriptionAnnonce;
  DateTime dateAnnonce;
  String image;
  DateTime dateFinAnnonce;
  Etat etat ;
  Categorie categorie;
  int idUtilPreneur;
  bool isFavorited = false;

  Annonce({
    required this.idAnnonce,
    required this.titreAnnonce,
    required this.descriptionAnnonce,
    required this.dateAnnonce,
    required this.dateFinAnnonce,
    required this.etat ,
    required this.image,
    required this.categorie,
    required this.utilPublieur,
    required this.idUtilPreneur,
    this.isFavorited = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_annonce': idAnnonce,
      'titre_annonce': titreAnnonce,
      'description_annonce': descriptionAnnonce,
      'date_annonce': dateAnnonce,
      'date_Fin_annonce': dateFinAnnonce,
      'etat': etat.id_Etat,
      'categorie': categorie.id_Cat,
      'util_publieur': utilPublieur.id_Util,
      'id_Util_preneur': idUtilPreneur
    };
  }

  Map<String, dynamic> toInsert() {
    return {
      'titre_annonce': titreAnnonce,
      'description_annonce': descriptionAnnonce,
      'date_annonce': dateAnnonce,
      'date_fin_annonce': dateFinAnnonce,
      'etat': etat.id_Etat,
      'categorie': categorie.id_Cat,
      'util_Publieur': utilPublieur.id_Util,
      'id_util_preneur': idUtilPreneur
    };
  }


  factory Annonce.fromMap(Map<String, dynamic> map) {
    return Annonce(
      idAnnonce: map['id_annonce'],
      titreAnnonce: map['titre_annonce'],
      descriptionAnnonce: map['description_annonce'],
      dateAnnonce: map['date_annonce'],
      dateFinAnnonce: map['date_fin_annonce'],
      etat: EtatProvider().getEtat(map['etat']),
      categorie: cat_Provider().getCategorie(map['categorie']),
      utilPublieur: UserProvider().getUser(map['util_publieur']),
      idUtilPreneur: map['id_util_preneur'],
      image: map['image'],
    );
  }



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