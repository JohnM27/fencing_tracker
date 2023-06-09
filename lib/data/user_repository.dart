import 'dart:convert';

import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String url = '${Constants.API_URL}/user';

  Future<List<dynamic>> getNameList() async {
    final Uri uri = Uri.parse('$url/names');
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != Constants.HTTP_GET_VALID_CODE) {
        print("error");
      }
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
