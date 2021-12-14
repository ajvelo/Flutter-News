import 'package:flutter_news/features/news/data/datasources/get_news_remote_data_source.dart';
import 'package:flutter_news/features/news/data/repositories/news_repository_impl.dart';
import 'package:flutter_news/features/news/domain/repositories/news_repository.dart';
import 'package:flutter_news/features/news/domain/usecases/get_news.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // NEWS:

  // Data

  // DataSources
  sl.registerLazySingleton<GetNewsRemoteDataSource>(
      () => GetNewsRemoteDatasSourceImpl(client: sl()));

  // Repositories
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(remoteDataSource: sl()));

  // Domain

  // Usecases
  sl.registerLazySingleton(() => GetNews(repository: sl()));

  // Presentation

  // Misc
  sl.registerLazySingleton(() => http.Client());
}
