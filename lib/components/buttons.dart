import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../asset/theme.dart' as theme;


NiceButtons buttonConnexion(BuildContext context, {Function? function}) {
return NiceButtons(
            startColor: theme.Theme.primaryColor,
            endColor: theme.Theme.primaryColor,
            borderColor: theme.Theme.primaryColor,
            stretch: false,
            progress: true,
            gradientOrientation: GradientOrientation.Horizontal,
            onTap: (finish) {
              Timer(const Duration(seconds: 1), () {
                finish();
                if (function != null) {
                  function();
                } else {
                  GoRouter.of(context).go('/sign');
                }
              });
            },
            child: Text(
              'Connexion',
              style: GoogleFonts.sora(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
}

NiceButtons buttonInscription(BuildContext context, Function signUpNewUser) {
return NiceButtons(
            startColor: theme.Theme.primaryColor,
            endColor: theme.Theme.primaryColor,
            borderColor: theme.Theme.primaryColor,
            stretch: false,
            progress: true,
            gradientOrientation: GradientOrientation.Horizontal,
            onTap: (finish) {
              Timer(const Duration(seconds: 1), () {
                finish();
                signUpNewUser();
              });
            },
            child: Text(
              'Inscription',
              style: GoogleFonts.sora(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
}

NiceButtons buttonVersConnexion(BuildContext context) {
return NiceButtons(
            startColor: theme.Theme.primaryColor,
            endColor: theme.Theme.primaryColor,
            borderColor: theme.Theme.primaryColor,
            stretch: false,
            progress: true,
            gradientOrientation: GradientOrientation.Horizontal,
            onTap: (finish) {
              Timer(const Duration(seconds: 1), () {
                finish();
                GoRouter.of(context).go('/sign');
              });
            },
            child: Text(
              'Connexion',
              style: GoogleFonts.sora(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
}

NiceButtons buttonAider(BuildContext context, {Function? function,int? idCat, bool? isAider}) {
return NiceButtons(
            startColor: isAider != null && isAider ? Colors.red : theme.Theme.primaryColor,
            endColor: isAider != null && isAider ? Colors.red : theme.Theme.primaryColor,
            borderColor: theme.Theme.primaryColor,
            stretch: false,
            progress: true,
            gradientOrientation: GradientOrientation.Horizontal,
            onTap: (finish) {
              Timer(const Duration(seconds: 1), () {
                finish();
              });
              if (function != null && idCat != null) {
                function(idCat);
              } 
            },
            child: Text(
              'Aider',
              style: GoogleFonts.sora(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
}


NiceButtons buttonProposer(BuildContext context) {
return NiceButtons(
            startColor: theme.Theme.primaryColor,
            endColor: theme.Theme.primaryColor,
            borderColor: theme.Theme.primaryColor,
            stretch: false,
            progress: true,
            gradientOrientation: GradientOrientation.Horizontal,
            onTap: (finish) {
              Timer(const Duration(seconds: 1), () {
                finish();
              });
            },
            child: Text(
              'Proposer',
              style: GoogleFonts.sora(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
}