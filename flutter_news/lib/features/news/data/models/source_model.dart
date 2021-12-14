import 'package:flutter_news/features/news/domain/entities/source.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'source_model.g.dart';

@HiveType(typeId: 1)
class SourceModel {
  @HiveField(0)
  final String name;

  SourceModel({
    required this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      name: json['name'],
    );
  }
}

extension SourceModelExtension on SourceModel {
  Source get toSource => Source(name: name);
}
