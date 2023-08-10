import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static final Api _api = Api._internal();
  final String baseUrl = "https://gateway.marvel.com:443/v1/public/";
  factory Api() {
    return _api;
  }

  Api._internal();

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }
}
