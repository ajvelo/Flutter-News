import 'package:dartz/dartz.dart';
import 'package:flutter_news/core/failures.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/features/news/domain/params/news_params.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews({required NewsParams parameters});
}
