import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_joke/views/screens/home_page.dart';

import 'controllers/theme_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    builder: (context, _) {
      return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: (Provider.of<ThemeProvider>(context).isDark)
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routes: {"/": (context) => const Home_page()});
    },
  ));
}
