import 'package:equatable/equatable.dart';
import 'package:flutter_news/features/news/data/models/source_model.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/features/news/domain/entities/source.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

part 'news_model.g.dart';

@HiveType(typeId: 0)
class NewsModel extends Equatable {
  @HiveField(0)
  final SourceModel source;

  @HiveField(1)
  final String? author;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String? urlToImage;

  @HiveField(5)
  final DateTime publishedDate;

  @HiveField(6)
  final String? content;

  const NewsModel(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.urlToImage,
      required this.publishedDate,
      required this.content});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        source: (SourceModel.fromJson(json['source'])),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        urlToImage: json['urlToImage'],
        publishedDate: DateTime.parse(json['publishedAt']),
        content: json['content']);
  }

  @override
  List<Object?> get props =>
      [source, author, title, description, urlToImage, publishedDate, content];
}

extension NewsModelExtension on NewsModel {
  News get toNews {
    final formattedDate = (DateFormat.yMMMMEEEEd().format(publishedDate));
    return News(
        author: author,
        title: title,
        description: description,
        urlToImage: urlToImage,
        publishedDate: formattedDate,
        content: content,
        source: source.toSource);
  }
}
