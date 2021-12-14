import 'package:flutter/material.dart';
import 'package:flutter_news/features/news/data/datasources/get_news_remote_data_source.dart';
import 'package:flutter_news/features/news/data/models/news_model.dart';
import 'package:flutter_news/features/news/data/models/source_model.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Text('Flutter Demo Home Page'),
    );
  }
}
