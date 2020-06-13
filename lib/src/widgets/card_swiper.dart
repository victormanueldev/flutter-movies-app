import 'package:flutter/material.dart';
import 'package:flutter_movies_app/src/models/movies.model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            // Assign the Unique ID to the movie
            movies[index].mid = '${ movies[index].id }-swipecards';
            return Hero(
              tag: movies[index].mid,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/movie_detail',
                        arguments: movies[index]),
                    child: FadeInImage(
                      image: NetworkImage(movies[index].getPosterUrl()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  )),
            );
          },
          itemCount: movies.length

          // pagination: new SwiperPagination(),
          // control: new SwiperControl()
          ),
    );
  }
}
