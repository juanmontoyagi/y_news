import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_news/src/pages/tabs_pages.dart';
import 'package:y_news/src/services/news_service.dart';
import 'package:y_news/src/theme/tema_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> new NewsService(), lazy: false,),
        //ChangeNotifierProvider(create: (_)=> new NewsService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: temaApp,
        debugShowCheckedModeBanner: false,
        home: TabsPage()
        ),
    );
  }
}