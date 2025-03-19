import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/response_articles.dart';

class Client{
  static Future<List<Article>> fetchArticle() async{
    const url =
        "https://newsapi.org/v2/everything?q=tesla&from=2025-02-12&sortBy=publishedAt&apiKey=77a1099d272644fc83ee48b8c1c33056";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ResponseArticles responseArticles =
        ResponseArticles.fromJson(responseBody);
      return responseArticles.articles;
    }else{
      throw Exception('Failed to load article');
    }
  }
}
