part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {}

class GetNewsEvent extends NewsEvent {
  final NewsParams parameters;

  GetNewsEvent({required this.parameters});
  @override
  List<Object?> get props => [];
}
