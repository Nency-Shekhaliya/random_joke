import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controllers/theme_provider.dart';

class Save_joke_page extends StatefulWidget {
  final List<String> storedJokes;
  Save_joke_page({super.key, required this.storedJokes});

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
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'History',
          style: GoogleFonts.aladin(
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 25,
              color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: const Icon(
              Icons.light_mode,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: widget.storedJokes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3),
            child: Card(
              elevation: 5,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0.5)),
              color: Colors.orange.shade100,
              child: ListTile(
                title: Text(
                  widget.storedJokes[index],
                  style: GoogleFonts.aladin(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.5,
                      color: Colors.black87.withOpacity(0.7)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
