import 'dart:convert';

import 'package:http/http.dart' as http;

class Api_helper {
  Api_helper._();
  static final Api_helper api_helper = Api_helper._();

  Future<Map?> getjoke() async {
    String api = 'https://api.chucknorris.io/jokes/random';
    Uri uri = Uri.parse(api);
    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      String jasondata = res.body;
      Map data = jsonDecode(jasondata);
      return data;
    }
    return null;
  }
}
