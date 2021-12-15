part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {}

class GetNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}
