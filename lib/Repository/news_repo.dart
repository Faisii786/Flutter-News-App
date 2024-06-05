// this code is used to fetch the data from internet using api

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/headlines_model.dart';

class NewsRepository {
  Future<NewsHeadlinesModel> fetchNewsHeadlines() async {
    // api url which i used 'newsapi.org' website
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=06e8f5b5e7094e2e9f0dd38fb5d300f5';

    // http package to get the data
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      // for return body
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
      // it will return complete body of data
    }
    throw Exception('Error');
  }
}
