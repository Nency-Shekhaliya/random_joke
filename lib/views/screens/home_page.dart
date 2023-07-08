import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:random_joke/controllers/theme_provider.dart';
import 'package:random_joke/models/globals.dart';
import 'package:random_joke/models/helpers/api_helper.dart';
import 'package:random_joke/views/screens/save_joke_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String joke = '';

  void loadStoredJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedJokesList = prefs.getStringList('storedJokes');

    if (storedJokesList != null) {
      setState(() {
        Global.storedJokes = storedJokesList;
      });
    }
  }

  void storeJoke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String jokeWithTime =
        '${now.hour}:${now.minute}\n${now.day}-${now.month}-${now.year}\n\n$joke';
    Global.storedJokes.add(jokeWithTime);
    await prefs.setStringList('storedJokes', Global.storedJokes);
  }

  void navigateToStoredJokesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Save_joke_page(storedJokes: Global.storedJokes)),
    );
  }

  @override
  void initState() {
    super.initState();
    loadStoredJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Random Joke',
          style: GoogleFonts.aladin(
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 30,
              color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: navigateToStoredJokesScreen,
            icon: Icon(
              Icons.list,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: Icon(
              Icons.light_mode,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 630,
                width: 380,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/joke2.png"),
                        opacity: 0.3,
                        scale: 1.3),
                    color: Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(25)),
                child: FutureBuilder(
                  future: Api_helper.api_helper.getjoke(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      Map? data = snapshot.data;

                      joke = data!['value'];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    storeJoke();
                                  },
                                  child: Icon(
                                    Icons.save_alt,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              joke,
                              style: GoogleFonts.aladin(
                                  fontSize: 30, letterSpacing: 2),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  height: 60,
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange),
                  child: Text(
                    "Fetch My Laugh",
                    style: GoogleFonts.aladin(
                        fontSize: 30,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
