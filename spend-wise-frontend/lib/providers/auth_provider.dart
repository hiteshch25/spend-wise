import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? get token => _token;

  Future<bool> login(String email, String password) async {
    var url = Uri.parse('http://localhost:8080/login');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      _token = jsonDecode(response.body)["user"];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
