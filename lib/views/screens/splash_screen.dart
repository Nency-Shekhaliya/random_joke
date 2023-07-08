import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_joke/views/screens/home_page.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home_page()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/joke2.png"),
                    opacity: 0.6)),
          ),
          Text(
            "Jokes",
            style: GoogleFonts.aladin(
                fontSize: 35,
                letterSpacing: 15,
                color: Colors.black87.withOpacity(0.5),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      backgroundColor: Colors.orange,
    );
  }
}
