import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
import 'package:sae_allo_mobile/model/sqflite/providers/objetProv.dart';
import 'package:go_router/go_router.dart';
class AddObjetPage extends StatefulWidget {
  @override
  _AddObjetPageState createState() => _AddObjetPageState();
}

class _AddObjetPageState extends State<AddObjetPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomObjetController = TextEditingController();
  final _descriptionObjetController = TextEditingController();
  final _imageObjetController = TextEditingController();

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
                  return 'Veuillez entrer une URL d\'image';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs

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
