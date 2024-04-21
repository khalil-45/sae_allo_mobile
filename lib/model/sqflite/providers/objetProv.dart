import 'package:sae_allo_mobile/model/sqflite/bd_locale.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
class ObjetProv{


  insertTest() async {
    final db = await BD_locale.instance.database;

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

}