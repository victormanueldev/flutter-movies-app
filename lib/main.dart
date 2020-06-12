import 'package:flutter/material.dart';

import 'package:flutter_movies_app/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
      },
    );
  }
}