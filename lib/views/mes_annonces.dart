import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MesAnnoncesPage extends StatefulWidget {
  @override
  _MesAnnoncesPageState createState() => _MesAnnoncesPageState();
}

class _MesAnnoncesPageState extends State<MesAnnoncesPage> {
  // Remplacez ceci par la liste de vos annonces
  List<Map<String, dynamic>> mesAnnonces = [
    {'title': 'Annonce 1', 'description': 'Description de l\'annonce 1'},
    {'title': 'Annonce 2', 'description': 'Description de l\'annonce 2'},
    // Ajoutez plus d'annonces ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Annonces'),
      ),
      body: ListView.builder(
        itemCount: mesAnnonces.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mesAnnonces[index]['title']),
            subtitle: Text(mesAnnonces[index]['description']),
            onTap: () {
              context.go('/home/annonces/${index.toString()}');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/home/annonces/add');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}