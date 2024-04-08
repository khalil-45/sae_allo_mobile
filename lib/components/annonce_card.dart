import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/Annonce.dart';

class AnnonceCardWidget extends StatefulWidget {
  final Annonce annonceRef;

  const AnnonceCardWidget({super.key, required this.annonceRef});

  @override
  _AnnonceCardWidgetState createState() => _AnnonceCardWidgetState();
}

class _AnnonceCardWidgetState extends State<AnnonceCardWidget> {
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/home/annonces/${widget.annonceRef?.idAnnonce ?? ''}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.48,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.annonceRef?.image ?? ''),
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Align(
              alignment: const AlignmentDirectional(1, -1),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 12, 0),
                child: Container(
                  width: 32,
                  height: 32,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(1, -1),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.grey[600],
                          size: 32,
                        ),
                      ),
                      // Add favorite icon if the Annonce is favorited
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Text(
              widget.annonceRef?.titreAnnonce ?? '',
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Add diet information if available
        ],
      ),
    );
  }
}