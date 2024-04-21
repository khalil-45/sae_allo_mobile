import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/model/sqflite/bd_locale.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
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
      String query = 'SELECT * FROM OBJET WHERE id_Cat = (SELECT id_Cat FROM CATEGORIE_OBJET WHERE nom_Cat = ?)';
      final db = await BD_locale.instance.database;
      final result = await db.rawQuery(query, [cat]);
      return result.map((e) => ObjetLocale.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return Future.value([]);
    }

  }

}