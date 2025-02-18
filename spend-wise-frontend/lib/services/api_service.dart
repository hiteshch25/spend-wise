import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8080";

  // Register a new parent
  static Future<bool> registerParent(String name, String email, String password) async {
    var url = Uri.parse('$baseUrl/register');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "parentName": name,
        "parentEmail": email,
        "parentPassword": password,
      }),
    );

    return response.statusCode == 200;
  }

  // Login function
  static Future<bool> login(String email, String password) async {
    var url = Uri.parse('$baseUrl/login');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 200;
  }

  // Fetch all cards
  static Future<List<dynamic>> fetchCards() async {
    var url = Uri.parse('$baseUrl/cards');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      print("Failed to fetch cards: ${response.statusCode} - ${response.body}");
      return [];
    }
  }


  // Add a new cash card
  static Future<bool> addCard(String cardName, double balance) async {
    var url = Uri.parse('$baseUrl/addCard');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "cardName": cardName,
        "balance": balance,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print("Failed to add card: ${response.statusCode} - ${response.body}"); // Debugging
      return false;
    }
  }

  // Update an existing card
  static Future<bool> updateCard(String cardId, String cardName, double balance) async {
    var url = Uri.parse('$baseUrl/updateCard/$cardId');
    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "cardName": cardName,
        "balance": balance,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("Failed to update card: ${response.statusCode} - ${response.body}"); // Debugging
      return false;
    }
  }


  // Delete a cash card
  static Future<bool> deleteCard(String cardId) async {
    var url = Uri.parse('$baseUrl/deleteCard/$cardId');
    var response = await http.delete(url);

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      print("Failed to delete card: ${response.statusCode} - ${response.body}"); // Debugging
      return false;
    }
  }

}
