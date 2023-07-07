import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:random_joke/models/globals.dart';
import 'package:random_joke/models/helpers/api_helper.dart';
import 'package:random_joke/models/utils/ss_utils.dart';
import 'package:random_joke/views/screens/save_joke_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/theme_provider.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String time = " ${DateTime.now().hour} : ${DateTime.now().minute}";
  String date =
      " ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}";

  Future<void> saveJoke(String joke) async {
    final prefs = await SharedPreferences.getInstance();
    final dateTime = DateTime.now().toString();
    final jokeData = jsonEncode({'joke': joke, 'dateTime': dateTime});
    prefs.setString(ssave, jokeData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Joke",
          style: GoogleFonts.aladin(
              fontSize: 25,
              letterSpacing: 7,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Save_joke_page(date: 'date', time: 'time', joke: ,),
              ));
            },
            icon: const Icon(
              Icons.library_add_check,
              color: Colors.black,
            ),
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 550,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/joke2.png",
                      ),
                      opacity: 0.2,
                      scale: 1.8),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: Api_helper.api_helper.getjoke(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("{$snapshot.error}");
                      } else if (snapshot.hasData) {
                        Map? data = snapshot.data;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Transform.scale(
                                              scale: 1,
                                              child: Icon(
                                                Icons.date_range_outlined,
                                                size: 18,
                                                color: Colors.black38,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(date,
                                                style: GoogleFonts.aladin(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
                                                    color: Colors.black38))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Transform.scale(
                                              scale: 1,
                                              child: Icon(
                                                  Icons.access_time_rounded,
                                                  size: 18,
                                                  color: Colors.black38),
                                            ),
                                            Text(time,
                                                style: GoogleFonts.aladin(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
                                                    color: Colors.black38))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Global.addjoke.add(data!['value']);
                                      Global.addjoke.add(date);
                                      Global.addjoke.add(time);
                                    },
                                    icon: const Icon(
                                      Icons.save_alt_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "${data!['value']}",
                                    style: GoogleFonts.aladin(
                                        fontSize: 25,
                                        color: Colors.black,
                                        letterSpacing: 3,
                                        wordSpacing: 6),
                                  )),
                            ),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Fetch My Laugh",
                  style: GoogleFonts.aladin(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 5,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
