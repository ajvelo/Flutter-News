import 'dart:convert';
import 'dart:io';

import 'package:flutter_news/features/news/data/models/news_model.dart';

String fixture(String name) =>
    File('test/features/news/fixtures/$name').readAsStringSync();

List<NewsModel> getMockFilms() {
  return (json.decode(fixture('news.json')) as List)
      .map((e) => NewsModel.fromJson(e))
      .toList();
}
