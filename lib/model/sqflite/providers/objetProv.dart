import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/model/sqflite/bd_locale.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
import 'package:sae_allo_mobile/const.dart';
import 'package:sae_allo_mobile/model/supabase/Annonce.dart';
import 'package:sae_allo_mobile/model/supabase/provider/annonceProv.dart';
class ObjetProv{

  insertTest() async {

    ObjetLocale obj = ObjetLocale(id_Objet: 1, nom_Objet: "test", description_objet: "mon objet", image_objet: "image", id_Cat: 1);

    insertObjet(obj);

  }

  insertObjet(ObjetLocale obj) async {
    final db = await BD_locale.instance.database;
    await db.insert('OBJET', obj.toInsert());
  }

  Future<List<ObjetLocale>> getAllObjet() async {
    final db = await BD_locale.instance.database;

    final result = await db.query('OBJET');

    return result.map((e) => ObjetLocale.fromMap(e)).toList();
  }

  Future<ObjetLocale> getObjet(int id) async {
    final db = await BD_locale.instance.database;

    final result = await db.query('OBJET', where: 'id_Objet = ?', whereArgs: [id]);

    return ObjetLocale.fromMap(result.first);
  }

  Future<List<ObjetLocale>> getObjetByCat(int cat) async{

    try {
      String query = 'SELECT * FROM OBJET WHERE id_Cat = ? AND id_Objet NOT IN (SELECT id_Objet FROM EST_PRETE)';
      final db = await BD_locale.instance.database;
      final result = await db.rawQuery(query, [cat]);
      return result.map((e) => ObjetLocale.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return Future.value([]);
    }

  }

  Future<void> pretObjet(idObjet, annonce) async {

      try {
        String query = 'INSERT INTO EST_PRETE (id_Util, id_Objet, date_debut, date_fin, id_Annonce) VALUES (?,?,?,?,?)';
        final db = await BD_locale.instance.database;
        await db.rawQuery(query, [user.id_Util, idObjet, annonce.dateAnnonce.toIso8601String(), annonce.dateFinAnnonce.toIso8601String().split('T')[0], annonce.idAnnonce]);
        log(user.id_Util.toString());
        await AnnonceProv().updateAnnoncePreter(annonce.idAnnonce, user.id_Util);
        log('Objet prêté');
      } catch (e) {
        debugPrint('Error: $e');        
      }
  } 


    Future<Map<String, dynamic>>  objetEstPreter(int idObjet) async {
    try {
      String query = 'SELECT * FROM EST_PRETE WHERE id_Objet = ?';
      final db = await BD_locale.instance.database;
      final result = await db.query('EST_PRETE', where: 'id_Objet = ?', whereArgs: [idObjet]);
      log(result.toString());
      return {...result.first, 'estPreter': true};
      }
    catch (e) {
      debugPrint('Error: $e');
      return {'estPreter': false};
    }
  }

}