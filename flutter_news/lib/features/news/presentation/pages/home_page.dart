import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/features/news/presentation/bloc/news_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        log(state.toString());
        if (state is NewsInitial) {
          return Center(
            child: FloatingActionButton(
              child: Text('Get News'),
              onPressed: () {
                BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
              },
            ),
          );
        }
        if (state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsLoadedWithSuccess) {
          final news = state.news;
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(news[index].title));
            },
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
