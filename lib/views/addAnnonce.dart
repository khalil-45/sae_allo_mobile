import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/const.dart';
import 'package:sae_allo_mobile/model/Annonce.dart';
import 'package:sae_allo_mobile/model/Categorie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sae_allo_mobile/model/provider/annonceProv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sae_allo_mobile/model/provider/CatProvider.dart';

class AddAnnoncesPage extends StatefulWidget {
  @override
  _AddAnnoncesPageState createState() => _AddAnnoncesPageState();
}

class _AddAnnoncesPageState extends State<AddAnnoncesPage> {
  final _formKey = GlobalKey<FormState>();
  final _titreController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateFinController = TextEditingController();
  final _idCategorieController = TextEditingController();
  DateTime _dateDebut = DateTime.now();
  DateTime _dateFin = DateTime.now();
  late Stream<List<Categorie>> lesCategories;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _idCategorieController.text = '-1'; // Initialiser avec une valeur vide
  }


  void fetchCategories() {
    lesCategories = CatProvider().categories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une annonce'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Vos champs de texte ici
            TextFormField(
              controller: _titreController,
              decoration: const InputDecoration(labelText: 'Titre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un titre';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs

            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs

            InputDatePickerFormField(
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              initialDate: DateTime.now(),
              onDateSubmitted: (DateTime value) {
                _dateDebut = value;
              },
              onDateSaved: (value) => _dateDebut = value,
              fieldLabelText: 'Date de Debut',
            ),

            const SizedBox(height: 20), // Ajout de padding entre les champs

            InputDatePickerFormField(
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              initialDate: DateTime.now().add(const Duration(days: 1)),
              onDateSubmitted: (DateTime value) {
                _dateFinController.text = value.toString();
              },
              onDateSaved: (value) => _dateFin = value,
              fieldLabelText: 'Date de fin',
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs

  
            // Champ ID Util Preneur désactivé et renommé
            TextFormField(
              enabled: false,
              decoration: const InputDecoration(labelText: 'Publieur'), // Renommé en Publieur
              initialValue: user.name, // Valeur par défaut
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un Publieur';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs
            // Champ ID Etat désactivé et renommé
            TextFormField(
              enabled: false,
              decoration: const InputDecoration(labelText: 'Etat'), // Renommé en Etat
              initialValue: 'Non publié', // Valeur par défaut
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un Etat';
                }
                return null;
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre les champs
            // Champs de menu déroulant pour la catégorie
            StreamBuilder<List<Categorie>>(
              stream: lesCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erreur: ${snapshot.error}'),
                  );
                } else {
                  return DropdownButtonFormField<String>(
                    items: snapshot.data!.map((Categorie categorie) {
                      return DropdownMenuItem(
                        value: categorie.id_Cat.toString(),
                        child: Text(categorie.nom_Cat),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _idCategorieController.text = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Catégorie'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez sélectionner une catégorie';
                      }
                      return null;
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20), // Ajout de padding entre le menu déroulant et le bouton
            // Bouton pour accorder le formulaire
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Traiter les données ici
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Formulaire accordé')),
                  );
                  log('id_Util: ${user.id_Util}');
                  Annonce annonce = Annonce(
                    titreAnnonce: _titreController.text,
                    descriptionAnnonce: _descriptionController.text,
                    dateAnnonce: _dateDebut,
                    dateFinAnnonce: _dateFin,
                    idCategorie: int.parse(_idCategorieController.text),
                    idUtilPublieur: user.id_Util,
                    idEtat: 1, // Valeur par défaut
                    idAnnonce: 0, // Valeur par défaut
                    image: "https://picsum.photos/250?image=1",
                    idUtilPreneur: -1
                  );
                  AnnonceProv().addAnnonce(annonce);
                  context.go('/mes-annonces');
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
