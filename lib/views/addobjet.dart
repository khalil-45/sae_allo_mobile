import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/categorie.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
import 'package:sae_allo_mobile/model/sqflite/providers/objetProv.dart';

import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/model/supabase/Categorie.dart';
import 'package:sae_allo_mobile/model/supabase/provider/CatProvider.dart';
class AddObjetPage extends StatefulWidget {
  @override
  _AddObjetPageState createState() => _AddObjetPageState();
}

class _AddObjetPageState extends State<AddObjetPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomObjetController = TextEditingController();
  final _descriptionObjetController = TextEditingController();
  final _imageObjetController = TextEditingController();
  late final Stream<List<Categorie>> lesCat;
  int idCat = 0;

  @override
  void initState() {
    super.initState();
    lesCat = CatProvider().categories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un objet'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Vos champs de texte ici
            TextFormField(
              controller: _nomObjetController,
              decoration: const InputDecoration(labelText: 'Nom de l\'objet'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom d\'objet';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs

            TextFormField(
              controller: _descriptionObjetController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs

            TextFormField(
              controller: _imageObjetController,
              decoration: const InputDecoration(labelText: 'Image (URL)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  _imageObjetController.text = 'https://picsum.photos/200/300?random=1';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs
            StreamBuilder<List<Categorie>>(
              stream: lesCat,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<Categorie>(
                    items: snapshot.data!.map((Categorie categorie) {
                      return DropdownMenuItem<Categorie>(
                        value: categorie,
                        child: Text(categorie.nom_Cat),
                      );
                    }).toList(),
                    onChanged: (Categorie? value) {
                      idCat = value!.id_Cat;
                    },
                    decoration: const InputDecoration(labelText: 'Catégorie'),
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez sélectionner une catégorie';
                      }
                      return null;
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            // Bouton pour accorder le formulaire
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Traiter les données ici
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Formulaire accordé')),
                  );
                  ObjetLocale objet = ObjetLocale(
                    id_Objet: 0, // L'ID sera généré automatiquement
                    nom_Objet: _nomObjetController.text,
                    description_objet: _descriptionObjetController.text,
                    image_objet: _imageObjetController.text,
                    id_Cat: idCat,
                  );
                  ObjetProv().insertObjet(objet);
                  context.go("/home/profil");
                }
              },
              child: const Text('Accorder'),
            ),
          ],
        ),
      ),
    );
  }
}
