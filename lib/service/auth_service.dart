import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  static const String baseUrl = 'http://10.0.2.2:3000/auth';

  Future<UserModel?> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      _currentUser = UserModel.fromJson(data);
      notifyListeners();
      return _currentUser;
    }
    return null;
  }

  Future<UserModel?> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );

    if (res.statusCode == 201) {
      final data = jsonDecode(res.body);
      _currentUser = UserModel.fromJson(data);
      notifyListeners();
      return _currentUser;
    }
    return null;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

