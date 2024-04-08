import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/components/buttons.dart';
import '../model/annonce.dart';

class AnnonceDetailsWidget extends StatefulWidget {
  AnnonceDetailsWidget({
    Key? key,
    required this.annonceRef,
  }) : super(key: key);

  Annonce annonceRef;

  @override
  State<AnnonceDetailsWidget> createState() => _AnnonceDetailsWidgetState();
}

class _AnnonceDetailsWidgetState extends State<AnnonceDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.annonceRef.image ??
                      'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                ),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.annonceRef.titreAnnonce,
                  style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  widget.annonceRef.descriptionAnnonce,
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                IconButton(
                          icon: Icon(
                            widget.annonceRef.isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.annonceRef.isFavorited =
                                  !widget.annonceRef.isFavorited;
                            });
                          },
                        ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Categorie: ${widget.annonceRef.categorie}',
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Date de debut: ${widget.annonceRef.dateAnnonce}',
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Date de fin : ${widget.annonceRef.dateFinAnnonce}',
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: buttonAider(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
