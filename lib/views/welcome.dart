import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/buttons.dart';


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
          Positioned(
        child: Align(
          alignment: AlignmentGeometry.lerp(Alignment.center, Alignment.bottomCenter, 0.9)!,
          child: buttonVersConnexion(context),
        ),
      ),
      ],
      ),
    );
  }
}