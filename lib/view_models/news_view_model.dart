import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  // Add a `String name` parameter to dynamically fetch headlines for the specified news channel
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String name) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(name);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
