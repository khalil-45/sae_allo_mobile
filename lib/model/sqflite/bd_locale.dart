import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

class BD_locale {
    static final BD_locale instance = BD_locale._init();
  static Database? _database;

  BD_locale._init();


 Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('laBD.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // reprendre la bd du fichier sqlitebd dans le même dossier
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    final db = await openDatabase(path, version: 1, onCreate: createDB);
    return db;
  }

  Future<void> createDB(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE CATEGORIE_OBJET (
        id_Cat INTEGER PRIMARY KEY AUTOINCREMENT,
        nom_Cat TEXT NOT NULL,
        description_Cat TEXT
      )
      ''');
      log("Table CATEGORIE_OBJET créée");
      await db.execute('''
      CREATE TABLE OBJET (
        id_Objet INTEGER PRIMARY KEY AUTOINCREMENT,
        nom_Objet TEXT ,
        description_objet TEXT ,
        id_Cat INTEGER ,
        FOREIGN KEY (id_Cat) REFERENCES CATEGORIE_OBJET(id_Cat)
      )
      ''');
      await db.execute('''
      CREATE TABLE ANNONCE(
        id_Annonce INTEGER PRIMARY KEY AUTOINCREMENT,
        titreAnnonce TEXT,
        descriptionAnnonce TEXT
      );
      ''');
      log("Table OBJET créée");
      log('Table ANNONCE créée');

      await db.execute('''
      CREATE TABLE EST_PRETE(
        id_Util INTEGER,
        id_Objet INTEGER,
        date_debut DATE,
        date_fin DATE,
        FOREIGN KEY (id_Util) REFERENCES UTILISATEUR(id_Util),
        FOREIGN KEY (id_Objet) REFERENCES OBJET(id_Objet)
      )
      ''');
      log("Table EST_PRETE créée");

    } catch (e) {
      log('Erreur lors de la création de la base de données: $e');
    }
  }

}
