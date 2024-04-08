import 'package:flutter/material.dart';

class AddAnnoncePage extends StatefulWidget {
  @override
  _AddAnnoncePageState createState() => _AddAnnoncePageState();
}

class _AddAnnoncePageState extends State<AddAnnoncePage> {
  final TextEditingController idAnnonceController = TextEditingController();
  final TextEditingController dateDebutController = TextEditingController();
  final TextEditingController dateFinController = TextEditingController();
  final TextEditingController categorieController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une annonce'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID Annonce',
                ),
                controller: idAnnonceController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date de début',
                ),
                controller: dateDebutController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date de fin',
                ),
                controller: dateFinController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Catégorie',
                ),
                controller: categorieController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                controller: descriptionController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Titre',
                ),
                controller: titreController,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ajoutez ici le code pour enregistrer l'annonce
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}