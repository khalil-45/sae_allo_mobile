import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:go_router/go_router.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/welcome_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Black gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black, Colors.transparent],
                stops: [0.3, 0.8]
              ),
            ),
          ),
          // Centered text
          Center(
            child: Align(
              alignment: AlignmentGeometry.lerp(Alignment.center, Alignment.bottomCenter, 0.6)!,
              child: Text(
                'Demander de l\'aide\nn\'a jamais été aussi simple avec ALL\'O.',
                style: GoogleFonts.sora(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
        child: Align(
          alignment: AlignmentGeometry.lerp(Alignment.center, Alignment.bottomCenter, 0.9)!,
          child: NiceButtons(
            startColor: const Color(0xFFC67C4E),
            endColor: const Color(0xFFC67C4E),
            borderColor: const Color(0xFFC67C4E),
            stretch: false,
            progress: true,
            gradientOrientation: GradientOrientation.Horizontal,
            onTap: (finish) {
              Timer(const Duration(seconds: 4), () {
                finish();
                context.go('/connexion');
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
          ),
        ),
      ),
      ],
      ),
    );
  }
}