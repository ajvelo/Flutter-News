import 'package:flutter_news/core/exceptions.dart';
import 'package:flutter_news/features/news/data/datasources/get_news_remote_data_source.dart';
import 'package:flutter_news/features/news/data/models/news_model.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final GetNewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<News>>> getNews() async {
    try {
      final newsModels = await remoteDataSource.getNews();
      final news = newsModels.map((e) => e.toNews).toList();
      return Right(news);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }
}
