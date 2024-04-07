import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/model/provider/UserProvider.dart';
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



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {



  Future<void> _getProfile() async {

    log('getProfile');

    try {

      final userExists = await UserProvider().userExists(_usernameController.text, _websiteController.text);

      if (userExists) {
        final user = await UserProvider().getUser(_usernameController.text);
        log('User: $user');
        context.go('/home');

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Utilisateur non trouvé'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }


    } catch (error) {
        SnackBar(
            content: Text(error.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
    }
  }



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

