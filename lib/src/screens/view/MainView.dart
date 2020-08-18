import 'package:flutter/material.dart';
import 'package:movie_track/src/screens/view/PeopleView.dart';
import 'package:movie_track/src/screens/view/Tabbed.dart';
import 'package:movie_track/src/screens/view/TvView.dart';
import 'package:movie_track/src/screens/view/MovieView.dart';


class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabbedMainView(
      titles: ["Movies", "Tv", "People"],
      views: [
        MovieView(),
        TvView(),
        PeopleView()
      ],
    );
  }
}