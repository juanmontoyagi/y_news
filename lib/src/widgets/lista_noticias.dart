import 'package:flutter/material.dart';
import 'package:y_news/src/theme/tema_app.dart';

import '../models/news/news_response.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;
  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index ) {
        return _Noticia(noticia: this.noticias[index], index: index,);
      }
      );
  }
}

class ListaNoticiasFuturo extends StatelessWidget {

  final Future<List<Article>> futureArticulos;

  const ListaNoticiasFuturo({required this.futureArticulos});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: futureArticulos,
      builder: (_, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Mientras se carga la lista
        } else if (snapshot.hasError) {
          return Text('Error al obtener los artículos: ${snapshot.error}');
        } else {
          // Una vez que el Future ha completado, construimos el ListView
          List<Article> noticias = snapshot.data!;
          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (BuildContext context, int index) {
              return _Noticia(noticia: noticias[index], index: index);
            },
          );
        }
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({super.key, required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia: noticia, index: index,),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        _TarjetaBotones(),
        SizedBox(height: 10),
        Divider()
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _TarjetaTopBar({super.key, required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text('${ index + 1}. ', style: TextStyle(color: Colors.red),),
          Text('${ noticia.source.name } .', style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;

  const _TarjetaTitulo({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _TarjetaImagen extends StatelessWidget{

  final Article noticia;

  const _TarjetaImagen({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (noticia.urlToImage != null) ?
          FadeInImage(
            placeholder: AssetImage('assets/giphy.gif'),
            image: NetworkImage(noticia.urlToImage),
          ) : Image(image: AssetImage('assets/no-image.png')),
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text( (noticia.description != null) ? noticia.description : '')
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.amber,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),

          SizedBox(width: 10,),

          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more_horiz),
          )

        ],
      ),
    );
  }
}