import 'package:flutter/material.dart';

class Constants {
  // DEV
  static String API_URL = "http://localhost:3000";
  // PROD
  // static String API_URL = "http://johnm.sytes.net:3000";

  static int HTTP_GET_VALID_CODE = 200;
  static int HTTP_POST_VALID_CODE = 201;
}

class CustomColors {
  static Color purple = const Color(0xFF881EA6);
  static Color red = const Color(0xFFE91717);
  static Color green = const Color(0xFF18E518);
  static Color black = const Color(0xFF2A2D30);
  static Color white = const Color(0xFFFADBDB);
}

class Utils {
  static int getCurrentSeason() {
    DateTime currentDate = DateTime.now();
    return currentDate.month > 8 ? currentDate.year + 1 : currentDate.year;
  }

  static String getCurrentSeason2Year() {
    DateTime currentDate = DateTime.now();
    return currentDate.month > 8
        ? '${currentDate.year}/${currentDate.year + 1}'
        : '${currentDate.year - 1}/${currentDate.year}';
  }

  static List<String> getListOfSeasons() {
    int currentSeason = getCurrentSeason();
    int listLength = currentSeason - 2022;

    List<String> result = [];

    for (var i = 0; i < listLength; i++) {
      int currentYear = 2022 + i;
      result.add('$currentYear/${currentYear + 1}');
    }
    return result;
  }
}
