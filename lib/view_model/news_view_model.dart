// ignore_for_file: unused_field, unused_local_variable

// import 'package:http/http.dart';
import 'package:news_app/Repository/News_Repository.dart';
import 'package:news_app/models/Channels_Headlines_Models.dart';

class Newsviewmodel {
  final _rep = NewsRepository();
  Future<NewsChannelsHeadlinesModels> fetchNewsChannelsApi() async {
    final response = await _rep.fetchNewsChannelsApi();
    return response;
  }
}
