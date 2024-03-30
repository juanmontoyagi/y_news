import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_news/src/services/news_service.dart';
import 'package:y_news/src/widgets/lista_noticias.dart';

class TabPage1 extends StatefulWidget {

  @override
  State<TabPage1> createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context).topHeadlines;

    return Scaffold(
      body: ( newsService.length == 0 ) 
      ? Center(child: CircularProgressIndicator())
      : ListaNoticias(newsService),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}