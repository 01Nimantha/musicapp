import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PageTestRemote {
  Future<Uint8List?> getimage({required String name}) async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:8000/image/$name"));

      if (response.statusCode == 200) {
        return response.bodyBytes; // Return the binary data as Uint8List
      } else {
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
        return null; // Return null if there was an error
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return null; // Return null if an exception occurred
    }
  }

  Future<Map<String, dynamic>?> getAllImages() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:8000/all-images"));

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        if (kDebugMode) {
          print('Failed to load images. Status code: ${response.statusCode}');
        }
        return {"Data": "null"} as Map<String, dynamic>;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return null;
    }
  }
}
