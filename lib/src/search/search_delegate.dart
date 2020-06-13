import 'package:flutter/material.dart';
import 'package:flutter_movies_app/src/models/movies.model.dart';
import 'package:flutter_movies_app/src/providers/movies.provider.dart';

class DataSearch extends SearchDelegate {

  String selection = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Ironman 2',
    'Avengers',
    'Cap',
    'Aquaman',
    'Parasite',
    'Ad astra'
  ];

  final trendingMovies = [
    'Doctor Sleep',
    'Mad max',
    'Hulk',
    'Shotblood',
    'Marver'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions in the AppBar, ie clean input and cancel
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon left to AppBar (Search Icon)
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () { close(context, null ); },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(child: Text(selection),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) {
       return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovies( query ),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if ( snapshot.hasData ){
          return ListView(
            children: snapshot.data.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage( movie.getPosterUrl() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  width: 50.0,
                ),
                title: Text( movie.title ),
                subtitle: Text( movie.originalTitle ),
                onTap: (){
                  close(context, null);
                  movie.mid = '';
                  Navigator.pushNamed(context, '/movie_detail', arguments: movie );
                },
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {

  //   final popularMovies = ( query.isEmpty ) 
  //     ? trendingMovies 
  //     : movies.where((m) => 
  //       m.toLowerCase().startsWith(query.toLowerCase())
  //     ).toList();

  //   return ListView.builder(
  //     itemCount: popularMovies.length,
  //     itemBuilder: (context,  index){
  //       return ListTile(
  //         leading: Icon( Icons.movie ),
  //         title: Text(popularMovies[index]),
  //         onTap: (){
  //           selection = popularMovies[index];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
