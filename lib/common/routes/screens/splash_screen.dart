import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff004c7f),
              Color(0xff001d31),
            ],
          ),
        ),
        child: Center(
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Q',
                  style: TextStyle(fontFamily: 'Moonhouse', fontSize: 64),
                ),
                TextSpan(
                  text: 'uik',
                  style: TextStyle(fontFamily: 'Moonhouse', fontSize: 48),
                ),
                TextSpan(
                  text: 'Hyr',
                  style: TextStyle(
                      fontFamily: 'Trap', fontSize: 48, letterSpacing: -1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
