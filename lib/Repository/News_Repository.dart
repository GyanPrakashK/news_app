// import 'dart:ffi';

// ignore_for_file: unused_local_variable, unused_import

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/Channels_Headlines_Models.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModels> fetchNewsChannelsApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=c1448ac9b8074ed0a1ac3f5b88806180';

    final responce = await http.get(Uri.parse(url));

    if (responce.statusCode == 200) {
      final body = jsonDecode(responce.body);
      return NewsChannelsHeadlinesModels.fromJson(body);
    }
    throw Exception('error');
  }
}
