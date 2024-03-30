import 'dart:async';
import 'package:flutter/material.dart';
import 'package:y_news/src/models/news/category_model.dart';
import 'package:y_news/src/models/news/news_response.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS = 'newsapi.org';
final _API_KEY= '4278ec1b470849e6a25c79926a937fd4';

class NewsService with ChangeNotifier {

  List<Article> topHeadlines = [];
  List<Article> articlesCategories = [];

  String _selectedCategory = 'business';

  List<Categoria> categories = [
    Categoria(Icons.business, 'business'),
    Categoria(Icons.tv, 'entertainment'),
    Categoria(Icons.width_normal, 'general'),
    Categoria(Icons.health_and_safety, 'health'),
    Categoria(Icons.science, 'science'),
    Categoria(Icons.sports_basketball, 'sport'),
    Categoria(Icons.computer, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    categories.forEach( (item) {
      categoryArticles[item.name];
    });
    this.getArticlesByCategory( this._selectedCategory );
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    this.getArticlesByCategory(_selectedCategory);
    notifyListeners();
  }

  getTopHeadlines() async {

    final url =
        Uri.https(_URL_NEWS, '/v2/top-headlines', {
          'country': 'co',
          'apiKey': _API_KEY,
        });

    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson(resp.body);
    this.topHeadlines.addAll(newsResponse.articles);
    notifyListeners();

  }

  Future<List<Article>>getArticlesByCategory(String categoria) async {
    final url =
        Uri.https(_URL_NEWS, '/v2/top-headlines', {
          'country': 'co',
          'apiKey': _API_KEY,
          'category': categoria
        });

    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(resp.body);
    this.articlesCategories.addAll(newsResponse.articles);
    return newsResponse.articles.toList();
  }

}