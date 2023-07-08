import 'dart:convert';

import 'package:http/http.dart' as http;

class Api_helper {
  Api_helper._();

  static final Api_helper api_helper = Api_helper._();

  String joke = '';

  Future<Map?> getjoke() async {
    String api = "https://api.chucknorris.io/jokes/random";
    Uri uri = Uri.parse(api);
    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      final jokeMap = jsonDecode(res.body);

      return jokeMap;
    } else {
      joke = 'Failed to fetch joke';
    }
  }
}
