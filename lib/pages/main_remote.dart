import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MainRemote {
  Future singer() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:8000/singer"));
      if (kDebugMode) {
        print(response.body);
        print(response.statusCode);
      }
      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future songs() async {}
}
