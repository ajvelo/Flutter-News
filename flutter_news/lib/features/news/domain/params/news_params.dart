import 'package:flutter/material.dart';

class NewsParams {
  final String country;
  final String category;

  NewsParams({required this.country, required this.category});
}

enum CategoryType {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology
}

extension CategoryTypeExtension on CategoryType {
  String get categoryName {
    switch (this) {
      case CategoryType.general:
        return 'General';
      case CategoryType.business:
        return 'Business';
      case CategoryType.entertainment:
        return 'Entertainment';
      case CategoryType.health:
        return 'Health';
      case CategoryType.science:
        return 'Science';
      case CategoryType.sports:
        return 'Sports';
      case CategoryType.technology:
        return 'Technology';
    }
  }

  IconData get categoryImage {
    switch (this) {
      case CategoryType.general:
        return Icons.info_rounded;
      case CategoryType.business:
        return Icons.business_rounded;
      case CategoryType.entertainment:
        return Icons.tv_rounded;
      case CategoryType.health:
        return Icons.health_and_safety_outlined;
      case CategoryType.science:
        return Icons.science_rounded;
      case CategoryType.sports:
        return Icons.sports_football_rounded;
      case CategoryType.technology:
        return Icons.computer_rounded;
    }
  }
}
