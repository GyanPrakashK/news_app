// import 'dart:ffi';

// ignore_for_file: unused_local_variable, unused_import

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/Channels_Headlines_Models.dart';

import '../models/Categories_News_Models.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModels> fetchNewsChannelsApi(
      String channelName) async {
    String url =
        // ignore: unnecessary_brace_in_string_interps
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=c1448ac9b8074ed0a1ac3f5b88806180';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModels.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CategoriesNewsModels> fetchCategoriesNewsapi(String categories) async {
    String url =
        // ignore: unnecessary_brace_in_string_interps
        'https://newsapi.org/v2/everything?q=${categories}&apiKey=c1448ac9b8074ed0a1ac3f5b88806180';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModels.fromJson(body);
    }
    throw Exception('Error');
  }
}
