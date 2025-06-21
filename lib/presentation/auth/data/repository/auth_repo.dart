import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepo {
  final String baseUrl = 'https://fastapi-books-app.onrender.com';

  Future<String> signUp(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/signup"),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success');
        return data['msg'].toString();
      }

      throw Exception(data['detail'].toString());
    } catch (e) {
      print('Error');
      rethrow;
    }
  }
}
