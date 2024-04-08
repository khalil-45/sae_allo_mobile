import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/buttons.dart';
import 'package:sae_allo_mobile/model/provider/UserProvider.dart';
import 'package:sae_allo_mobile/model/Utilisateurs.dart';


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


  @override
  Widget build(BuildContext context) {


  Future<void> signUpNewUser() async {
    try {
      String email = emailController.text;
      String motDePasse = passwordController.text;
      String prenom = firstNameController.text;
      String nom = lastNameController.text;
      String phone = phoneController.text;
      String pseudo = pseudoController.text;

      if (email != null && email.isNotEmpty) {
        UserProvider().addUser(Utilisateur(
          id_Util: -1,
          pseudo_Util: pseudo,
          mdp_util: motDePasse,
          nom_Util: nom,
          prenom_Util: prenom,
          email_Util: email,
          telephone: phone,
        ));
      } else if (phone != null && phone.isNotEmpty) {
        UserProvider().addUser(Utilisateur(
          id_Util: -1,
          pseudo_Util: pseudo,
          mdp_util: motDePasse,
          nom_Util: nom,
          prenom_Util: prenom,
          email_Util: email,
          telephone: phone,
        ));
      } 

      context.go('/home');

      
    } on AuthException catch (e) {
      log(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );   
    } on PostgrestException catch (e) {
      log('Erreur lors de l\'inscription: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
    catch (e) {
      log('Erreur lors de l\'inscription: ${e.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Une erreur est survenue lors de l\'inscription"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
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
                signUpNewUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
