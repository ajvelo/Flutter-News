import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news/core/failures.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/features/news/domain/entities/source.dart';
import 'package:flutter_news/features/news/domain/params/news_params.dart';
import 'package:flutter_news/features/news/domain/usecases/get_news.dart';
import 'package:flutter_news/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNews extends Mock implements GetNews {}

void main() {
  late MockGetNews mockGetNewsUsecase;
  late NewsBloc newsBloc;

  final List<News> news = [
    News(
        author: 'author',
        title: 'title',
        description: 'description',
        urlToImage: 'urlToImage',
        publishedDate: DateTime.now(),
        content: 'content',
        source: const Source(name: 'name')),
    News(
        author: 'author 2',
        title: 'title 2',
        description: 'description 2',
        urlToImage: 'urlToImage 2',
        publishedDate: DateTime.now(),
        content: 'content 2',
        source: const Source(name: 'name 2'))
  ];

  final newsParams = NewsParams(country: 'GB', category: 'health');

  setUp(() {
    mockGetNewsUsecase = MockGetNews();
    newsBloc = NewsBloc(getNewsUsecase: mockGetNewsUsecase);
  });

  group('GET News Usecase', () {
    test('Inital bloc state should be NewsInitial', () {
      expect(newsBloc.state, equals(NewsInitial()));
    });

    test('Bloc calls GetNews usecase', () async {
      // Arrange
      when(() => mockGetNewsUsecase.execute(parameters: newsParams))
          .thenAnswer((invocation) async => Right(news));
      // Act
      newsBloc.add(GetNewsEvent(parameters: newsParams));
      await untilCalled(
          () => mockGetNewsUsecase.execute(parameters: newsParams));
      // Assert
      verify(() => mockGetNewsUsecase.execute(parameters: newsParams));
    });

    blocTest(
      'Should emit correct order or states when GetNews is called with success',
      build: () {
        when(() => mockGetNewsUsecase.execute(parameters: newsParams))
            .thenAnswer((invocation) async => Right(news));
        return newsBloc;
      },
      act: (_) {
        return newsBloc.add(GetNewsEvent(parameters: newsParams));
      },
      expect: () {
        return [NewsLoading(), NewsLoadedWithSuccess(news: news)];
      },
    );

    blocTest(
      'Should emit correct order or states when GetNews is called with error',
      build: () {
        when(() => mockGetNewsUsecase.execute(parameters: newsParams))
            .thenAnswer(
                (invocation) async => Left(ServerFailure(message: 'Error')));
        return newsBloc;
      },
      act: (_) {
        return newsBloc.add(GetNewsEvent(parameters: newsParams));
      },
      expect: () {
        return [NewsLoading(), NewsLoadedWithError(message: 'Error')];
      },
    );
  });
}
