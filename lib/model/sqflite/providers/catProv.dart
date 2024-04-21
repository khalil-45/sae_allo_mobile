import 'dart:developer';

import 'package:sae_allo_mobile/model/sqflite/bd_locale.dart';
import 'package:sae_allo_mobile/model/supabase/provider/CatProvider.dart';
import 'package:sae_allo_mobile/model/supabase/Categorie.dart';
class CatProvLocale{

  insertTest() async {


  try {
    final les_cat =  CatProvider().categories();
    les_cat.forEach((element) {
      for (var cat in element) {
        insertCat(cat);
      }
    });
  } catch (e) {
    // Handle the error here
    log('Error: $e');
  }
  
    }


  insertCat(Categorie cat) async {
    final db = await BD_locale.instance.database;
    await db.insert('CATEGORIE_OBJET', cat.toInsert());
  }


}