import 'dart:convert';
import 'package:flutter_application_news/model/articles.dart';
import 'package:http/http.dart' as http;
 
class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '87e16e53680f485db14b4ec46681ae54';
  static const String _category = 'business';
  static const String _country = 'us';
 
  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse("${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}