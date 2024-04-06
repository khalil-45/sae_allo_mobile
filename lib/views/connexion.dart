import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';
import 'package:sae_allo_mobile/style/bouton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sae_allo_mobile/main.dart';


class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  _ConnexionState createState() => _ConnexionState();

}

class _ConnexionState extends State<Connexion> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _lesUsers = supabase.from('utilisateur').stream(primaryKey: ['id_Util']);
  

  bool _loading = true;


  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    log('getProfile');

    try {

      // afficher les tables de la base de données
      final tables = supabase.from('utilisateur').select();

      Stream<List<Utilisateur>> lstUtil = tables.asStream().map((response) {
        log(response.toString());
        final List<Utilisateur> lstUtil = [];
        for (final row in response) {
          lstUtil.add(Utilisateur.fromMap(row));
        }
        return lstUtil;
      });  

      
      lstUtil.forEach((element) { 
        log(element.toString());
        });

      final data = await supabase
          .from('utilisateur')
          .select()
          .eq('id_Util', 1)
          .single();

      

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
              TextField(
                controller : _usernameController,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0), // Add some space between the input fields
              TextField(
                controller: _websiteController,
                obscureText: true,
                decoration: const InputDecoration(
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

