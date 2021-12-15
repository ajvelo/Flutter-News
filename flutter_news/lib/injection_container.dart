import 'package:flutter_news/features/news/data/datasources/news_hive_helper.dart';
import 'package:flutter_news/features/news/data/datasources/news_local_data_source.dart';
import 'package:flutter_news/features/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter_news/features/news/data/repositories/news_repository_impl.dart';
import 'package:flutter_news/features/news/domain/repositories/news_repository.dart';
import 'package:flutter_news/features/news/domain/usecases/get_news.dart';
import 'package:flutter_news/features/news/presentation/bloc/news_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // NEWS:

  // Data

  // DataSources
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(hive: sl()));

  // Repositories
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));

  // Domain

  // Usecases
  sl.registerLazySingleton(() => GetNews(repository: sl()));

  // Presentation

  // BLoC
  sl.registerFactory(() => NewsBloc(getNewsUsecase: sl()));

  // Misc
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => NewsHiveHelper());
}
