import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future getData() async {
    var jsonDecoder;
    var u = Uri.parse(url);
    http.Response response = await http.get(u);
    if (response.statusCode == 200) {
      String data = response.body;
      jsonDecoder = jsonDecode(data);
    } else {
      print(response.statusCode);
    }
    return jsonDecoder;
  }
}
