import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:newsapp/models/spaceResponse.dart';

class SpaceApiServices {
  final String _url = "https://services.isrostats.in/api/launches";

  Dio? _dio;

  SpaceApiServices() {
    _dio = Dio();
  }

  Future<List<Space>> fetchSpaceArticle() async {
    try {
      final response = await _dio!.get(_url);
      if (response.statusCode == 200) {
        final List<Space> spaceList =
            spaceListFromJson(json.encode(response.data));
        return spaceList;
      } else {
        print("Failed to fetch space data. Status code: ${response.statusCode}");
        return []; // Return an empty list or handle the error appropriately
      }
    } catch (error) {
      print("An error occurred: $error");
      rethrow;
    }
  }
}
