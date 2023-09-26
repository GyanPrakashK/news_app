// ignore_for_file: unused_field, unused_local_variable

// import 'package:http/http.dart';
import 'package:news_app/Repository/News_Repository.dart';
import 'package:news_app/models/Channels_Headlines_Models.dart';

import '../models/Categories_News_Models.dart';

class Newsviewmodel {
  final _rep = NewsRepository();
  Future<NewsChannelsHeadlinesModels> fetchNewsChannelsApi(String channelName) async {
    final response = await _rep.fetchNewsChannelsApi(channelName);
    return response;
  }

   Future<CategoriesNewsModels> fetchCategoriesNewsapi(String categories) async {
    final response = await _rep.fetchCategoriesNewsapi(categories);
    return response;
  }
}
