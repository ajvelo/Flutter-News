import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_news/features/news/presentation/widgets/news_of_the_day.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
          final news = state.news;
          final newsOfTheDay = state.news.first;
          return Column(
            children: [
              SizedBox(
                height: size.height / 2,
                child: Stack(
                  fit: StackFit.expand,
                  children: [NewsOfTheDay(newsOfTheDay: newsOfTheDay)],
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
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final newsSingle = news[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: size.height / 6,
                              width: size.width / 1.6,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(32),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: newsSingle.urlToImage != null
                                          ? NetworkImage(newsSingle.urlToImage!)
                                          : const AssetImage(
                                                  'assets/images/breaking_news.png')
                                              as ImageProvider)),
                            ),
                            Text(newsSingle.publishedDate.toIso8601String())
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
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
