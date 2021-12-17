import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';
import 'package:flutter_news/features/news/domain/params/news_params.dart';
import 'package:flutter_news/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_news/features/news/presentation/pages/detail_page.dart';
import 'package:flutter_news/features/news/presentation/widgets/category_chip.dart';
import 'package:flutter_news/features/news/presentation/widgets/headlines.dart';
import 'package:flutter_news/features/news/presentation/widgets/news_of_the_day.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  onNewsSelected({required News news, required BuildContext context}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(news: news),
        ));
  }

  onCategorySelected({required int index, required bool selected}) {
    setState(() {
      if (selected) {
        _selectedIndex = index;
        BlocProvider.of<NewsBloc>(context).add(GetNewsEvent(
            parameters: NewsParams(
                country:
                    WidgetsBinding.instance?.window.locale.countryCode ?? 'GB',
                category: CategoryType.values[_selectedIndex].categoryName)));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent(
        parameters: NewsParams(
            country: WidgetsBinding.instance?.window.locale.countryCode ?? 'GB',
            category: CategoryType.general.categoryName)));
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
                height: size.height / 2.5,
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: size.width,
                  child: Text('Breaking News',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline1),
                ),
              ),
              SizedBox(
                height: 96,
                child: CategoryChips(
                  selectedIndex: _selectedIndex,
                  onSelected: (index, selected) =>
                      onCategorySelected(index: index, selected: selected),
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
