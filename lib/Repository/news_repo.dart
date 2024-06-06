// this code is used to fetch the data from internet using api

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/everything_news_model.dart';
import 'package:news_app/Model/headlines_model.dart';

class NewsRepository {
  // final String apiKey = dotenv.env['API_KEY']!;
  final String apiKey = dotenv.env['API_KEY']!;
  // fetch bbc news
  Future<NewsHeadlinesModel> fetchNewsHeadlines() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  // fetch business news
  Future<EverythingNewsModel> fetcheverythingNewsHeadlines() async {
    // String url =
    //     'https://newsapi.org/v2/everything?q=bitcoin&apiKey=06e8f5b5e7094e2e9f0dd38fb5d300f5';
    String url =
        'https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return EverythingNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
