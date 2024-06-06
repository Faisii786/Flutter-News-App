import 'package:news_app/Model/everything_news_model.dart';
import 'package:news_app/Model/headlines_model.dart';
import 'package:news_app/Repository/news_repo.dart';

// Return the data
class NewsViewModel {
  final repo = NewsRepository();

  Future<NewsHeadlinesModel> fetchNewsHeadlines() async {
    final response = await repo.fetchNewsHeadlines();
    return response;
  }

  Future<EverythingNewsModel> fetcheverythingNewsHeadlines() async {
    final response = await repo.fetcheverythingNewsHeadlines();
    return response;
  }
}
