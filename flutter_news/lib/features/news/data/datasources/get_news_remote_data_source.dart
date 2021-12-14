import 'dart:convert';

import 'package:flutter_news/core/constants.dart';
import 'package:flutter_news/core/exceptions.dart';
import 'package:flutter_news/features/news/data/models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class GetNewsRemoteDataSource {
  Future<List<NewsModel>> getNews();
}

class GetNewsRemoteDatasSourceImpl implements GetNewsRemoteDataSource {
  final http.Client client;

  final baseUrl = "https://newsapi.org/v2";

  GetNewsRemoteDatasSourceImpl({required this.client});
  @override
  Future<List<NewsModel>> getNews() => _getDataFromUrl(
      path: "/top-headlines?country=gb&apiKey=${Constants.apiKey}");

  Future<List<NewsModel>> _getDataFromUrl({required String path}) async {
    try {
      final response = await client.get(Uri.parse(path), headers: {
        'Content-Type': 'application/json',
      });
      switch (response.statusCode) {
        case 200:
          final results = (json.decode(response.body)['articles']);
          final news =
              (results as List).map((e) => NewsModel.fromJson(e)).toList();
          print(news);
          return news;
        case 400:
          throw ServerException(message: 'Bad Request');
        case 401:
          throw ServerException(message: 'Unauthorized');
        case 500:
          throw ServerException(message: 'Internal Server Error');
        default:
          throw ServerException(message: 'Unknown Error');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
