import 'dart:convert';
import 'dart:io';

import 'package:fencing_tracker/application/authentication_service.dart';
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

  Future<List<dynamic>> getUsers({
    required BuildContext context,
    required bool includeCurrentUser,
  }) async {
    final Uri uri = Uri.parse(
      // url,
      '$url?${Uri(queryParameters: {
            'includeCurrentUser': '$includeCurrentUser',
          }).query}',
    );
    try {
      http.Response response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${AuthenticationService.fromProvider(
            context,
            listen: false,
          ).accessToken}'
        },
      );
      if (response.statusCode != Constants.HTTP_GET_VALID_CODE) {
        throw Exception();
      }
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
