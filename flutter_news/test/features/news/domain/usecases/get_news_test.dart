import 'package:dartz/dartz.dart';
import 'package:flutter_news/core/failures.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/features/news/domain/entities/source.dart';
import 'package:flutter_news/features/news/domain/params/news_params.dart';
import 'package:flutter_news/features/news/domain/repositories/news_repository.dart';
import 'package:flutter_news/features/news/domain/usecases/get_news.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

main() {
  late GetNews usecase;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNews(repository: mockNewsRepository);
  });

  final news = [
    News(
        author: "author",
        title: "title",
        description: "description",
        urlToImage: "https://img.youtube.com/vi/CA-Xe_M8mpA/maxresdefault.jpg",
        publishedDate: DateTime.now(),
        content: "content",
        source: const Source(name: "name"))
  ];

  final newsParams = NewsParams(country: 'GB', category: 'health');

  group('Retrieve news from repository', () {
    test('Should return entity from repository when call is successfull',
        () async {
      // Arrange
      when(() => mockNewsRepository.getNews(parameters: newsParams))
          .thenAnswer((invocation) async => Right(news));
      // Act
      final result = await usecase.execute(parameters: newsParams);
      // Assert
      expect(result, Right(news));
      verify(() => mockNewsRepository.getNews(parameters: newsParams));
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test('Should return failure from repository when call is unsuccessfull',
        () async {
      // Arrange
      final errorMessage = ServerFailure(message: "Internal Server Error");
      when(() => mockNewsRepository.getNews(parameters: newsParams))
          .thenAnswer((invocation) async => Left(errorMessage));
      // Act
      final result = await usecase.execute(parameters: newsParams);
      // Assert
      expect(result, Left(errorMessage));
      verify(() => mockNewsRepository.getNews(parameters: newsParams));
      verifyNoMoreInteractions(mockNewsRepository);
    });
  });
}
