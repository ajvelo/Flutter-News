class ServerException implements Exception {
  final String message;

  const ServerException({required this.message});
}

class CacheException implements Exception {}
