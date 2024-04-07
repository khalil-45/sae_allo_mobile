import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/buttons.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({Key? key}) : super(key: key);

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
              buttonConnexion(context),
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