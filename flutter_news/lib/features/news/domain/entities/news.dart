import 'package:equatable/equatable.dart';
import 'package:flutter_news/features/news/domain/entities/source.dart';

class News extends Equatable {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String? urlToImage;
  final String publishedDate;
  final String? content;

  const News(
      {required this.author,
      required this.title,
      required this.description,
      required this.urlToImage,
      required this.publishedDate,
      required this.content,
      required this.source});
  @override
  List<Object?> get props =>
      [source, author, title, description, urlToImage, publishedDate, content];
}
