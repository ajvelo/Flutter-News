import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/core/themes.dart';
import 'package:flutter_news/features/news/data/models/news_model.dart';
import 'package:flutter_news/features/news/data/models/source_model.dart';
import 'package:flutter_news/features/news/domain/params/news_params.dart';
import 'package:flutter_news/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_news/features/news/presentation/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsModelAdapter());
  Hive.registerAdapter(SourceModelAdapter());
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => di.sl<NewsBloc>()
            ..add(GetNewsEvent(
                parameters: NewsParams(category: 'technology', country: 'GB'))),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News',
        theme: Themes.appTheme,
        home: const HomePage(),
      ),
    );
  }
}
