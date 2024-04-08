import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController pseudoController = TextEditingController();

  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pseudo',
              ),
              controller: pseudoController,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => {
                signOut(),
                context.go('/connexion')
              },
              child: Text('Déconnexion'),
            ),
          ],
        ),
      ),
    );
  }
}