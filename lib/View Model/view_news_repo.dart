import 'package:news_app/Model/categories_news_model.dart';
import 'package:news_app/Model/headlines_model.dart';
import 'package:news_app/Repository/news_repo.dart';

// Return the data
class NewsViewModel {
  final repo = NewsRepository();

  Future<NewsHeadlinesModel> fetchNewsHeadlines(String channelName) async {
    final response = await repo.fetchNewsHeadlines(channelName);
    return response;
  }

  Future<CatergoriesModel> fetchcategoriesNewsHeadlines(
      String categoryName) async {
    final response = await repo.fetchcategoriesNewsHeadlines(categoryName);
    return response;
  }
}
