import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_allo_mobile/const.dart';
import 'package:sae_allo_mobile/model/sqflite/classe/objet.dart';
import 'package:sae_allo_mobile/model/sqflite/providers/objetProv.dart';
import 'package:sae_allo_mobile/model/supabase/Utilisateurs.dart';
import 'package:sae_allo_mobile/model/supabase/provider/UserProvider.dart';

class profil extends StatefulWidget {
  const profil({Key? key}) : super(key: key);

  @override
  _profilState createState() => _profilState();
}

class _profilState extends State<profil> {
  late final Future<Utilisateur> utilisateur;
  late final Future<List<ObjetLocale>> mes_objets;


  @override
  void initState() {
    super.initState();
  fetch_user_info();
  }

  fetch_user_info() async {
    utilisateur = UserProvider().getUser(user.id_Util);
    mes_objets = ObjetProv().getAllObjet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: FutureBuilder<Utilisateur>(
        future: utilisateur,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erreur de chargement"),
            );
          } else {
            return ListView(
              children: [
                ListTile(
                  title: Text("Nom"),
                  subtitle: Text(snapshot.data!.nom_Util),
                ),
                ListTile(
                  title: Text("Prenom"),
                  subtitle: Text(snapshot.data!.prenom_Util),
                ),
                ListTile(
                  title: Text("Email"),
                  subtitle: Text(snapshot.data!.email_Util),
                ),
                ListTile(
                  title: Text("Telephone"),
                  subtitle: Text(snapshot.data!.telephone),
                ),
                ListTile(
                  title: Text("Objets"),
                  subtitle: FutureBuilder<List<ObjetLocale>>(
                    future: mes_objets,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Erreur de chargement"),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data![index].nom_Objet),
                              subtitle: Text(snapshot.data![index].description_objet),
                              onTap: () => context.go('/home/objet/${snapshot.data![index].id_Objet}'),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/home/objet/add');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );



  }


}