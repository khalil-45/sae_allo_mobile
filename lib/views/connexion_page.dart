import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/buttons.dart';
import 'package:sae_allo_mobile/model/provider/UserProvider.dart';

class ConnexionPage extends StatefulWidget {
  ConnexionPage({Key? key}) : super(key: key);



  @override
  _ConnexionPageState createState() => _ConnexionPageState();

}

class _ConnexionPageState extends State<ConnexionPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {


  Future<void> signInWithEmail() async {
    try {
      log('signInWithEmail: ${emailController.text}');
      log('signInWithEmail: ${passwordController.text}');

      final res = await UserProvider().userExists(emailController.text, passwordController.text);
      // log(res.toString());
      if (res.id_Util == -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Utilisateur non trouvé'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }else{
        context.go('/home');
      }

    }on AuthException catch (e) {
      log('signInWithEmail: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }catch (e) {
      log('signInWithEmail: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
              const SizedBox(height: 16.0), // Add some space between the input fields
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                ),
                controller: passwordController,
              ),
              const SizedBox(height: 16.0), // Add some space between the input fields and the button
              buttonConnexion(context, function: signInWithEmail),
              const SizedBox(height: 16.0), // Add some space between the button and the text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Pas inscrit ?"),
                  TextButton(
                    onPressed: () {
                      context.go('/inscription');
                    },
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}