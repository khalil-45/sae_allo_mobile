import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/style/bouton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  _ConnexionState createState() => _ConnexionState();

}

class _ConnexionState extends State<Connexion> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  

  bool _loading = true;


  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    log('getProfile');

    try {

      // afficher les tables de la base de données
      final tables = await Supabase.instance.client.from('information_schema.tables').select('table_name');
      log('tables: ${tables.toString()}');

      final data = await Supabase.instance.client
          .from('utilisateur')
          .select()
          .eq('id', 1)
          .single();

          
                  
      log('data: ${data.toString()}');

      _usernameController.text = (data['prenom_util'] ?? '') as String;
      _websiteController.text = (data['mdp_Util'] ?? '') as String;
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }

  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Image.asset('images/logo_appli.png'),
                const Text(
                  'Connectez-vous à votre compte',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
              const SizedBox(height: 100.0), // Add some space between the text and input fields
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0), // Add some space between the input fields
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                ),
              ),
              const SizedBox(height: 16.0), // Add some space between the input fields and the button
              buttonConnexion(_getProfile),
            ],
          ),
        ),
      ),
    );
  }

}

