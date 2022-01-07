import 'package:flutter/material.dart';
import 'package:movie_track/src/screens/view/widgets/Tabbed.dart';
import 'package:movie_track/src/screens/view/widgets/TvView.dart';
import 'package:movie_track/src/screens/view/widgets/MovieView.dart';


class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabbedMainView(
        titles: ["Movies", "Tv", "Watch Later"],
        views: [
          MovieView(),
          TvView(),
          Container(),
        ],
      );
  }
}