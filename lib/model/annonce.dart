import 'package:sae_allo_mobile/model/Categorie.dart';
import 'package:sae_allo_mobile/model/Etat.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';

class Annonce {

  final int id_Annonce;
  final Utilisateur util_Publieur;
  String titre_Annonce;
  String description_Annonce;
  DateTime date_Annonce;
  DateTime date_Fin_Annonce;
  Etat etat;
  Categorie categorie;
  Utilisateur id_Util_Preneur;

  Annonce({
    required this.id_Annonce,
    required this.titre_Annonce,
    required this.description_Annonce,
    required this.date_Annonce,
    required this.date_Fin_Annonce,
    required this.etat,
    required this.categorie,
    required this.util_Publieur,
    required this.id_Util_Preneur,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_annonce': id_Annonce,
      'titre_annonce': titre_Annonce,
      'description_annonce': description_Annonce,
      'date_annonce': date_Annonce,
      'date_Fin_annonce': date_Fin_Annonce,
      'etat': etat.id_Etat,
      'categorie': categorie.id_Cat,
      'util_publieur': util_Publieur.id_Util,
      'id_Util_preneur': id_Util_Preneur
    };
  }

  Map<String, dynamic> toInsert() {
    return {
      'titre_annonce': titre_Annonce,
      'description_annonce': description_Annonce,
      'date_annonce': date_Annonce,
      'date_fin_annonce': date_Fin_Annonce,
      'etat': etat.id_Etat,
      'categorie': categorie.id_Cat,
      'util_Publieur': util_Publieur.id_Util,
      'id_util_preneur': id_Util_Preneur
    };
  }

  // static Annonce fromMap(Map<String, dynamic> map) {
  //   return Annonce(
  //     id_Annonce: map['id_Annonce'],
  //     titre_Annonce: map['titre_Annonce'],
  //     description_Annonce: map['description_Annonce'],
  //     date_Annonce: map['date_Annonce'],
  //     date_Fin_Annonce: map['date_Fin_Annonce'],
  //     etat: Etat.fromMap(map['etat']),
  //     categorie: Categorie.fromMap(map['categorie']),
  //     util_Publieur: Utilisateur.fromMap(map['util_Publieur']),
  //     id_Util_Preneur: Utilisateur.fromMap(map['id_Util_Preneur']),
  //   );
  // }



}