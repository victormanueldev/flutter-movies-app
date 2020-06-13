import 'package:flutter/material.dart';
import 'package:flutter_movies_app/src/providers/movies.provider.dart';
import 'package:flutter_movies_app/src/widgets/card_swiper.dart';
import 'package:flutter_movies_app/src/widgets/movies_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopularMovies();

    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[_swipeCards(), _footer(context)]),
        ));
  }

  Widget _swipeCards() {
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
              child: Text('Trending', style: Theme.of(context).textTheme.subtitle1)
            ),
          SizedBox(height: 7.0),
          StreamBuilder(
            stream: moviesProvider.popularMoviesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopularMovies,
                );
              } else {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
