import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_news/features/news/presentation/pages/detail_page.dart';
import 'package:flutter_news/features/news/presentation/widgets/headlines.dart';
import 'package:flutter_news/features/news/presentation/widgets/news_of_the_day.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  onNewsSelected({required News news, required BuildContext context}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(news: news),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsLoadedWithSuccess) {
          final news = state.news.sublist(1);
          final newsOfTheDay = state.news.first;
          return Column(
            children: [
              SizedBox(
                height: size.height / 2,
                child: Stack(
                  children: [
                    NewsOfTheDay(
                      newsOfTheDay: newsOfTheDay,
                      onPressed: (News news) {
                        onNewsSelected(news: news, context: context);
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: size.width,
                  child: Text('Breaking News',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline1),
                ),
              ),
              Expanded(
                child: Headlines(
                  news: news,
                  size: size,
                  onPressed: (news) {
                    onNewsSelected(news: news, context: context);
                  },
                ),
              ),
            ],
          );
        } else if (state is NewsLoadedWithError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
