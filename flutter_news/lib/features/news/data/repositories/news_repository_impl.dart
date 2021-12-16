import 'package:flutter_news/core/exceptions.dart';
import 'package:flutter_news/features/news/data/datasources/news_local_data_source.dart';
import 'package:flutter_news/features/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter_news/features/news/data/models/news_model.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<News>>> getNews() async {
    try {
      final newsModels = await remoteDataSource.getNews();
      await localDataSource.saveNews(newsModels);
      final news = newsModels.map((e) => e.toNews).toList();
      return Right(news);
    } on ServerException catch (error) {
      try {
        final newsModels = await localDataSource.getNews();
        final news = newsModels.map((e) => e.toNews).toList();
        return Right(news);
      } on CacheException {
        return Left(ServerFailure(message: error.message));
      }
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
