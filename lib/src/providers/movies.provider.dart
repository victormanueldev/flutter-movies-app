import 'dart:async';
import 'dart:convert';

import 'package:flutter_movies_app/src/models/actors.model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movies_app/src/models/movies.model.dart';

class MoviesProvider {

  String _apiKey   = '0e598c572309d418e93b1a075de1d38f';
  String _url      = 'api.themoviedb.org';
  String _language = 'en-EN';
  int _popularMoviesPage = 0;
  bool _loading = false;

  /*
   * Stream Structure
   */
  /// Create the Type and Var that will fluid in the stream
  List<Movie> _popularMovies = new List();

  /// Create the Stream Controller
  final _popularMoviesStreamController = StreamController<List<Movie>>.broadcast();

  // Create the Getter functions

  /// Sink Funtion: This add Data into stream
  Function(List<Movie>) get popularMoviesSink => _popularMoviesStreamController.sink.add;

  /// Stream Function: This allows to listen the stream
  Stream<List<Movie>> get popularMoviesStream => _popularMoviesStreamController.stream; 

  void disposeStream() {
    _popularMoviesStreamController?.close();
  }


  Uri _getUri(String page, { String numPage }) {
    if ( numPage == null ) {
      return Uri.https(_url, page, {
        'api_key'   :  _apiKey,
        'language'  : _language
      });
    } else {
      return Uri.https(_url, page, {
        'api_key'   :  _apiKey,
        'language'  : _language,
        'page'      : numPage
      });
    }
  }

  Future<List<Movie>> _getMovies(String resultParam, String page, { String numPage }) async {
    // Build whole URL with Query paramss
    final wholeUri = _getUri(page, numPage: numPage);
    // Make a HTTP Request
    final apiResp = await http.get(wholeUri);
    // Decode Raw HTTP Response to JSON
    final decodedJson = json.decode(apiResp.body);
    // Parse JSON to dart List
    final movies = Movies.fromJsonToList(decodedJson[resultParam]);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async => await _getMovies('results', '3/movie/now_playing');

  Future<List<Movie>> getPopularMovies() async {

    if ( _loading ) return [];
    _loading = true;

    _popularMoviesPage++; 
    final movies = await _getMovies('results', '3/movie/popular', numPage: _popularMoviesPage.toString() );
    _popularMovies.addAll( movies );
    popularMoviesSink( _popularMovies );

    _loading = false;
    return movies;
  }

  Future<List<Actor>> getCast( String movieId ) async {
    // Build whole URL with Query paramss
    final wholeUri = _getUri('3/movie/$movieId/credits');
    // Make a HTTP Request
    final apiResp = await http.get(wholeUri);
    // Decode Raw HTTP Response to JSON
    final decodedJson = json.decode(apiResp.body);
    // Parse JSON to dart List
    final items = Cast.fromJsonToList(decodedJson['cast']);

    return items.actors;
  }

}