import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:y_news/src/models/news/category_model.dart';
import 'package:y_news/src/services/news_service.dart';
import 'package:y_news/src/widgets/lista_noticias.dart';

class TabPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(
              child: ListaNoticiasFuturo(futureArticulos: newsService.getArticlesByCategory(newsService.selectedCategory))
            )


          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
      
          final categoryName = categories[index].name;
      
          return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categoria: categories[index]),
                  SizedBox(height: 5,),
                  Text('${ categoryName[0].toUpperCase() }${categoryName.substring(1)}')
                ],
              ),
          );
        },
      
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Categoria categoria;

  const _CategoryButton({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
          ? Colors.red
          : Colors.black54,
        ),
      ),
    );
  }
}