import 'package:flutter/material.dart';
import 'package:flutter_movies_app/src/models/actors.model.dart';
import 'package:flutter_movies_app/src/models/movies.model.dart';
import 'package:flutter_movies_app/src/providers/movies.provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitle(context, movie),
              _movieDesc(movie),
              _movieDesc(movie),
              _movieDesc(movie),
              _createCasting(movie)
            ]),
          )
        ],
      ),
    );
  }

  Widget _appBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackdropUrl()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
      expandedHeight: 172.0,
      floating: false,
      pinned: true,
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(movie.getPosterUrl()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _movieDesc(Movie movie) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
        ));
  }

  Widget _createCasting(Movie movie) {
    final movieProvider = new MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createCastPageView(snapshot.data);
        } else {
          return Container(child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _createCastPageView(List<Actor> actors) {
    return SizedBox(
        height: 200.0,
        child: PageView.builder(
            controller: PageController(initialPage: 1, viewportFraction: 0.3),
            pageSnapping: false,
            itemCount: actors.length,
            itemBuilder: (context, index) => _createActorCard(actors[index])));
  }

  Widget _createActorCard(Actor actor) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
                image: NetworkImage(actor.getImageUrl()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
