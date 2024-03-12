import 'package:flutter/material.dart';

class Connexion extends StatelessWidget{
  const Connexion({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: const Center(
        child: Text('Connexion'),
      ),
    );
  }
}