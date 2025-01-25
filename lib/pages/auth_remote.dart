import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthRemote {
  Future signup({
    required String name,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/user"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "password": password,
        }),
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 400) {
        return false;
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future login({
    required String name,
    required String password,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/$name/$password"),
      );

      if (kDebugMode) {
        print(response.body);
        print(response.statusCode);
      }
      if (response.statusCode == 400) {
        return false;
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
