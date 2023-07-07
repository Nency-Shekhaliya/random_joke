import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_joke/models/globals.dart';

class Save_joke_page extends StatefulWidget {
  String date;
  String time;
  String joke;
  Save_joke_page(
      {super.key, required this.date, required this.time, required this.joke});

  @override
  State<Save_joke_page> createState() => _Save_joke_pageState();
}

class _Save_joke_pageState extends State<Save_joke_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "History",
          style: GoogleFonts.aladin(
              fontSize: 25,
              letterSpacing: 7,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(children: [
        ListView.builder(
          itemCount: Global.addjoke.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(),
          ),
        )
      ]),
    );
  }
}
