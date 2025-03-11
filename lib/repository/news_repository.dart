import 'dart:convert';
import 'package:newsapp/models/categories_news_model.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/news_channel_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String name) async {
    String apiKey = ''; //ENTER YOUR API KEY
    String url = 'https://newsapi.org/v2/top-headlines?sources=$name&apiKey=$apiKey';
    
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error fetching news for $name');
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String apiKey = 'a9e622138724420c9973e18140d8b3e3';
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=${apiKey}';
    
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error fetching news for $category');
  }
}
