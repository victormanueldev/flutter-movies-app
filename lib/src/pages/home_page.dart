import 'package:flutter/material.dart';
import 'package:flutter_movies_app/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
            child: Column(children: <Widget> [ swipeCards() ]
          ),    
        ));
  }

  Widget swipeCards() {
    return CardSwiper(movies: null);
  }
}
