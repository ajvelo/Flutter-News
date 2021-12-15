import 'dart:io';

import 'package:flutter_news/core/exceptions.dart';
import 'package:flutter_news/features/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late NewsRemoteDataSourceImpl remoteDataSourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    remoteDataSourceImpl = NewsRemoteDataSourceImpl(client: mockClient);
    registerFallbackValue(Uri());
  });

  void setUpMockHttpClient(String fixtureName, int statusCode) {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((invocation) async => http.Response(
              fixture(fixtureName),
              statusCode,
              headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              },
            ));
  }

  group('GET News', () {
    test(
        'Should return a list of news models when a status code of 200 is received',
        () async {
      // Arrange
      setUpMockHttpClient('news.json', 200);
      // Act
      final news = await remoteDataSourceImpl.getNews();
      // Assert
      expect(news.length, equals(20));
    });

    test('should throw an exception when a status code of 400 is received',
        () async {
      // Arrange
      setUpMockHttpClient('news.json', 400);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getNews(),
          throwsA(predicate(
              (e) => e is ServerException && e.message == 'Bad Request')));
    });

    test('should throw an exception when a status code of 401 is received',
        () async {
      // Arrange
      setUpMockHttpClient('news.json', 401);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getNews(),
          throwsA(predicate(
              (e) => e is ServerException && e.message == 'Unauthorized')));
    });

    test('should throw an exception when a status code of 500 is received',
        () async {
      // Arrange
      setUpMockHttpClient('news.json', 500);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getNews(),
          throwsA(predicate((e) =>
              e is ServerException && e.message == 'Internal Server Error')));
    });

    test(
        'should throw an exception of Unknown Error when a non recognised status code is received',
        () async {
      // Arrange
      setUpMockHttpClient('news.json', 300);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getNews(),
          throwsA(predicate(
              (e) => e is ServerException && e.message == 'Unknown Error')));
    });
  });
}
