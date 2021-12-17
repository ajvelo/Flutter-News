import 'package:dartz/dartz.dart';
import 'package:flutter_news/core/failures.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/features/news/domain/params/news_params.dart';
import 'package:flutter_news/features/news/domain/repositories/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews({required this.repository});

  Future<Either<Failure, List<News>>> execute(
      {required NewsParams parameters}) async {
    return repository.getNews(parameters: parameters);
  }
}
