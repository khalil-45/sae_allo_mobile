import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart' as theme;


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
                  GoRouter.of(context).go('/connexion');
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

NiceButtons buttonInscription(BuildContext context, TextEditingController emailController, TextEditingController passwordController, TextEditingController firstNameController, TextEditingController lastNameController, TextEditingController phoneController, TextEditingController pseudoController, Function signUpNewUser) {
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
                signUpNewUser(emailController.text, passwordController.text, firstNameController.text, lastNameController.text, phoneController.text, pseudoController.text);
                context.go('/home');
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
                GoRouter.of(context).go('/connexion');
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

NiceButtons buttonAider(BuildContext context) {
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