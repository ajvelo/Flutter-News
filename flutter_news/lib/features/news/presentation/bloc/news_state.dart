part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {}

class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoadedWithSuccess extends NewsState {
  final List<News> news;

  NewsLoadedWithSuccess({required this.news});
  @override
  List<Object?> get props => [news];
}

class NewsLoadedWithError extends NewsState {
  final String message;

  NewsLoadedWithError({required this.message});
  @override
  List<Object?> get props => [message];
}
