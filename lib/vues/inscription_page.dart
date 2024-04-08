import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/buttons.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pseudoController = TextEditingController();

  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signUpNewUser(String email, String motDePasse, String prenom,
      String nom, String phone, String pseudo) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: motDePasse,
        data: {
          'prenom': prenom,
          'nom': nom,
          'phone': phone,
          'pseudo': pseudo,
        }
      );

      context.go('/home');
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
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
                      'Créez votre compte',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height:
                      100.0), // Add some space between the text and input fields
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom',
                ),
                controller: lastNameController,
              ),
              const SizedBox(
                  height: 16.0), // Add some space between the input fields
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prénom',
                ),
                controller: firstNameController,
              ),
              const SizedBox(
                  height: 16.0), // Add some space between the input fields
              TextField(
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
              const SizedBox(
                  height: 16.0), // Add some space between the input fields
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                ),
                controller: passwordController,
              ),
              const SizedBox(
                  height: 16.0), // Add some space between the input fields
              TextField(
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Téléphone',
                ),
                controller: phoneController,
              ),
              const SizedBox(
                  height:
                      16.0), // Add some space between the input fields and the button
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pseudo',
                ),
                controller: pseudoController,
              ),
              const SizedBox(height: 16.0), 
              buttonInscription(
                context,
                emailController,
                passwordController,
                firstNameController,
                lastNameController,
                phoneController,
                pseudoController,
                signUpNewUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
