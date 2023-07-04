import 'dart:convert';
import 'dart:io';

import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MatchRepository {
  final String url = '${Constants.API_URL}/match';

  Future<List<dynamic>> getUserMatches({
    required BuildContext context,
    DateTime? date,
  }) async {
    final Uri uri = Uri.parse(
      '$url/fromUser?${Uri(queryParameters: {
            'date': date != null
                ? '${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}'
                : null,
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

  Future<List<dynamic>> getCountMatches({required BuildContext context}) async {
    final Uri uri = Uri.parse(
      '$url/count',
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

  Future<void> createMatch({
    required BuildContext context,
    required int nbTouches,
    required int opponentId,
    required int givenTouches,
    required int receivedTouches,
    required bool isWin,
  }) async {
    AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);

    final Uri uri = Uri.parse(url);
    final Object body = {
      'nbTouches': nbTouches,
      'matchType': 'PRACTICE',
      'score': [
        {
          "userId": authenticationService.user.id,
          "givenTouches": givenTouches,
          "isWin": isWin,
        },
        {
          "userId": opponentId,
          "givenTouches": receivedTouches,
          "isWin": !isWin,
        },
      ],
    };
    try {
      http.Response response = await http.post(
        uri,
        body: json.encode(body),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${authenticationService.accessToken}',
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode != Constants.HTTP_POST_VALID_CODE) {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
