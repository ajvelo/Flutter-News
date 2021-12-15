import 'package:flutter_news/core/exceptions.dart';
import 'package:flutter_news/features/news/data/models/news_model.dart';

import 'news_hive_helper.dart';

abstract class NewsLocalDataSource {
  Future<List<NewsModel>> getNews();
  saveNews(List<NewsModel> newsModels);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final NewsHiveHelper hive;

  NewsLocalDataSourceImpl({required this.hive});

  @override
  Future<List<NewsModel>> getNews() async {
    final news = await hive.getNews();
    if (news.isNotEmpty) {
      return news;
    } else {
      throw CacheException();
    }
  }

  @override
  saveNews(List<NewsModel> newsModels) {
    return hive.saveNews(newsModels);
  }
}
