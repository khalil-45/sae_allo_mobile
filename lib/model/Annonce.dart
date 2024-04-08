import 'dart:developer';

import 'package:sae_allo_mobile/model/Categorie.dart';
import 'package:sae_allo_mobile/model/Etat.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';
import 'package:sae_allo_mobile/model/provider/CatProvider.dart';
import 'package:sae_allo_mobile/model/provider/EtatProvider.dart';
import 'package:sae_allo_mobile/model/provider/UserProvider.dart';


class Annonce {

  final int idAnnonce;
  final int idUtilPublieur;
  String titreAnnonce;
  String descriptionAnnonce;
  DateTime dateAnnonce;
  String image;
  DateTime dateFinAnnonce;
  int idEtat ;
  int idCategorie;
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
      'description': descriptionAnnonce,
      'date_debut': dateAnnonce,
      'date_fin': dateFinAnnonce,
      'etat': idEtat,
      'categorie': idCategorie,
      'util_publieur': idUtilPublieur,
      'id_Util_preneur': idUtilPreneur
    };
  }

  Map<String, dynamic> toInsert() {
    return {
      'titre_annonce': titreAnnonce,
      'description': descriptionAnnonce,
      'date_debut': dateAnnonce.toString(),
      'date_fin': dateFinAnnonce.toString(),
      'etat': idEtat,
      'categorie': idCategorie,
      'util_publieur': idUtilPublieur,
      'id_util_rep': idUtilPreneur
    };
  }

  static  _toObject(Future<Object> object) async {
    return await object;
  }


  factory Annonce.fromMap( map)  {
    for (var key in map.keys) {
      print('Key: $key  : ${map[key]} , ${map[key].runtimeType}' );
    }

    try {



    return Annonce(
      idAnnonce: map['id_annonce'],
      titreAnnonce: map['titre_annonce'],
      descriptionAnnonce: map['description'],
      dateAnnonce: DateTime.parse(map['date_debut']),
      dateFinAnnonce: DateTime.parse(map['date_fin']),
      idEtat: map['etat'] ?? 0,
      idCategorie: map['categorie'] ?? 0,
      idUtilPublieur: map['util_publieur'] ?? 0,
      idUtilPreneur: map['id_util_rep'] ?? 0,
      image: map['image'] ?? 'https://picsum.photos/250?image=1',
    );
  }




}