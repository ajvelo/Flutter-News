import 'dart:convert';

import 'package:flutter_news/features/news/data/models/news_model.dart';
import 'package:flutter_news/features/news/data/models/source_model.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final model = NewsModel(
      source: const SourceModel(name: "The Guardian"),
      author: "Graeme Wearden",
      title:
          "UK inflation soars to 10-year high of 5.1% as cost of living squeeze tightens – business live - The Guardian",
      description: "Rolling coverage of the latest economic and financial news",
      urlToImage:
          "https://i.guim.co.uk/img/media/2c70c5eef5b248710501db9a8f76273c905862fe/0_71_6000_3600/master/6000.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctbGl2ZS5wbmc&enable=upscale&s=51300a897c72bbc43fc4e4baee6ff552",
      publishedDate: DateTime.parse("2021-12-15T08:43:40Z"),
      content: "test content");

  group('Model matches JSON', () {
    test('should successfully convert to a News entity', () {
      // Assert
      expect(model.toNews, isA<News>());
    });

    test('Should deserialize model from JSON', () {
      // Arrange
      final jsonMap = json.decode(fixture('news_model.json'));
      // Act
      final news = NewsModel.fromJson(jsonMap);
      // Assert
      expect(news, equals(model));
      expect(news.author, model.author);
      expect(news.source, model.source);
      expect(news.content, model.content);
      expect(news.description, model.description);
      expect(news.publishedDate, model.publishedDate);
      expect(news.title, model.title);
      expect(news.urlToImage, model.urlToImage);
    });
  });
}
