import 'package:flutter/material.dart';
import 'package:movie_track/src/screens/view/MainView.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Movie Track',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainView(),
    );
  }
}