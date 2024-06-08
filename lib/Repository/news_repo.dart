// this code is used to fetch the data from internet using api

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/categories_news_model.dart';
import 'package:news_app/Model/headlines_model.dart';

class NewsRepository {
  // final String apiKey = dotenv.env['API_KEY']!;
  final String apiKey = dotenv.env['API_KEY']!;
  // fetch bbc news
  Future<NewsHeadlinesModel> fetchNewsHeadlines(String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  // fetch Categeroies news
  Future<CatergoriesModel> fetchcategoriesNewsHeadlines(
      String categoryName) async {
    String url =
        'https://newsapi.org/v2/everything?q=$categoryName&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CatergoriesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
