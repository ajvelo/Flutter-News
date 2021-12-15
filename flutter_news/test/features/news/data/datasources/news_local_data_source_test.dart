import 'dart:convert';

import 'package:flutter_news/core/exceptions.dart';
import 'package:flutter_news/features/news/data/datasources/news_hive_helper.dart';
import 'package:flutter_news/features/news/data/datasources/news_local_data_source.dart';
import 'package:flutter_news/features/news/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockNewsHiveHelper extends Mock implements NewsHiveHelper {}

void main() {
  late NewsLocalDataSourceImpl localDataSourceImpl;
  late MockNewsHiveHelper hive;

  setUp(() {
    hive = MockNewsHiveHelper();
    localDataSourceImpl = NewsLocalDataSourceImpl(hive: hive);
  });

  final expectedResult = (json.decode(fixture('cached_news.json')) as List)
      .map((e) => NewsModel.fromJson(e))
      .toList();

  group('Get News', () {
    test('Should return a list of news from cache when there is data in cache',
        () async {
      // Arrange
      when(() => hive.getNews())
          .thenAnswer((invocation) => Future.value(expectedResult));
      // Act
      final news = await localDataSourceImpl.getNews();
      // Assert
      expect(news, expectedResult);
    });

    test('Should throw a cache exception cache when there is no data in cache',
        () async {
      // Arrange
      when(() => hive.getNews())
          .thenAnswer((invocation) => Future.value(List.empty()));
      // Act
      // Assert
      expect(() async => localDataSourceImpl.getNews(),
          throwsA(predicate((e) => e is CacheException)));
    });
  });

  group('Save News', () {
    test('Should call Hive to cache data', () async {
      // Arrange
      when(() => hive.saveNews(any()))
          .thenAnswer((invocation) => Future.value(true));
      // Act
      await localDataSourceImpl.saveNews(expectedResult);
      // Assert
      verify(() => hive.saveNews(expectedResult)).called(1);
      verifyNoMoreInteractions(hive);
    });
  });
}
