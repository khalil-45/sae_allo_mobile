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
    required this.idEtat ,
    required this.image,
    required this.idCategorie,
    required this.idUtilPublieur,
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

factory Annonce.fromMap(Map<String, dynamic> map) {

  for (var item in map.entries) {
    log('Key: ${item.key}, Value: ${item.value} : ${item.value.runtimeType}');
  }
  try {
    return Annonce(
      idAnnonce: map['id_annonce'] ?? -1,
      titreAnnonce: map['titre_annonce'] ?? 'Annonce non trouvée',
      descriptionAnnonce: map['description'] ?? 'Aucune annonce trouvée',
      dateAnnonce: DateTime.tryParse(map['date_debut'] ?? '') ?? DateTime.now(),
      dateFinAnnonce: DateTime.tryParse(map['date_fin'] ?? '') ?? DateTime.now(),
      idEtat: int.tryParse(map['id_etat'].toString()) ?? 0,
      idCategorie: int.tryParse(map['id_cat'].toString()) ?? 0,
      idUtilPublieur: map['id_util_pub'] ?? 0,
      idUtilPreneur: int.tryParse(map['id_util_rep'].toString()) ?? 0,
      image: map['image'] ?? 'https://picsum.photos/250?image=1',
    );
  } catch (e) {
    print('Error creating Annonce object: $e');
    return Annonce(
      idAnnonce: -1,
      titreAnnonce: 'Annonce non trouvée',
      descriptionAnnonce: 'Aucune annonce trouvée',
      image: 'https://picsum.photos/250?image=1',
      isFavorited: false,
      dateAnnonce: DateTime.now(),
      dateFinAnnonce: DateTime.now(),
      idCategorie: 0,
      idUtilPreneur: 0,
      idUtilPublieur: 0,
      idEtat: 0,
    );
  }
}

  @override
  String toString() {
    return 'Annonce{idAnnonce: $idAnnonce, titreAnnonce: $titreAnnonce, descriptionAnnonce: $descriptionAnnonce, dateAnnonce: $dateAnnonce, dateFinAnnonce: $dateFinAnnonce, idEtat: $idEtat, idCategorie: $idCategorie, idUtilPublieur: $idUtilPublieur, idUtilPreneur: $idUtilPreneur, isFavorited: $isFavorited}';
  }


}