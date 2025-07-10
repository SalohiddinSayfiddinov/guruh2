import 'dart:convert';

import 'package:guruh2/core/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  Future<String> signUp(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${Api.baseUrl}/auth/signup"),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'name': '',
          "email": email,
          "password": password,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data['msg'].toString();
      }

      throw Exception(data['detail'].toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verify(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}/auth/verify'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({"email": email, "otp": otp}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data['msg'];
      }
      throw Exception(data['detail'] ?? 'Failed to verify');
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}/auth/login'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await prefs.setString('token', data['access_token']);
        return 'Success';
      }
      throw Exception(data['detail'] ?? 'Loginda error');
    } catch (e) {
      rethrow;
    }
  }
}
