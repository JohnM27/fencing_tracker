import 'dart:convert';

import 'package:fencing_tracker/utils/constants.dart';
import 'package:fencing_tracker/utils/exception.dart';
import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  final String url = '${Constants.API_URL}/auth';
  BrowserClient httpClient = BrowserClient()..withCredentials = true;
  // final Map<String, String> headers = {
  //   "Access-Control-Allow-Origin": "*",
  //   "Access-Control-Allow-Credentials": "true"
  // };

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final Uri uri = Uri.parse('$url/login');
    final Object body = {
      'username': username,
      'password': password,
    };
    try {
      http.Response response = await httpClient.post(
        uri,
        body: body,
      );
      if (response.statusCode != Constants.HTTP_POST_VALID_CODE) {
        throw LoginFailure();
      }
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> refresh() async {
    final Uri uri = Uri.parse('$url/refresh');
    try {
      http.Response response = await httpClient.post(
        uri,
      );
      if (response.statusCode != Constants.HTTP_POST_VALID_CODE) {
        throw LoginFailure();
      }
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
