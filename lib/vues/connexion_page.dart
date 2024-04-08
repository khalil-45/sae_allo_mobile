import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/buttons.dart';

class ConnexionPage extends StatelessWidget {
  ConnexionPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signInWithEmail(String email, String password, BuildContext context) async {
  try {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur de connexion : ${e.toString()}')),
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
              buttonConnexion(context, emailController, passwordController, signInWithEmail),
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