import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'theme.dart' as theme;


NiceButtons buttonConnexion(Function onTapFunction) {
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
        log('Connexion En Cours...');
        onTapFunction(); // Call the provided function
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