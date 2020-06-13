import 'package:flutter/material.dart';
import 'package:flutter_movies_app/src/models/movies.model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
  
    _pageController.addListener(() {
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){ 
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: ( BuildContext context, int index) =>  _card(context, movies[index])
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
      final _card = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: FadeInImage(
                image: NetworkImage(movie.getPosterUrl()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 125.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

      return GestureDetector(
        child: _card, 
        onTap: (){
          Navigator.pushNamed(context, '/movie_detail', arguments: movie);
      });
  }

  List<Widget> _moviesCards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: FadeInImage(
                image: NetworkImage(movie.getPosterUrl()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 125.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
