import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_track/src/screens/search/MovieSearchView.dart';
import 'package:movie_track/src/screens/search/TvSearchView.dart';

class SearchView extends StatefulWidget {
  createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
  Timer? _debounce;
  String? _mode;

  initState() {
    super.initState();
    _mode = "movie";
  }

  dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      print(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black87,
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.black,
                leading: TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                title: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search movies...',
                      hintStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  onChanged: _onSearchChanged,
                ),
              )),
          Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.black),
                      child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white24,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          indicator: UnderlineTabIndicator(
                            insets: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                          ),
                          tabs: [
                            Tab(text: 'Movie'),
                            Tab(
                              text: 'Tv',
                            )
                          ]),
                    ),
                    Expanded(
                        child: Container(
                      child: TabBarView(
                        children: [MovieSearchView(), TvSearchView()],
                      ),
                    ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

//Container(
//              height: 65,
//              decoration: BoxDecoration(
//                color: Colors.black,
//              ),
//              child: SafeArea(
//                child: TextField(
//                  decoration: InputDecoration(
//                    border: InputBorder.none,
//                    hintText: 'Search movies...',
//                    hintStyle: TextStyle(
//                      color: Colors.white,
//                    )
//                  ),
//                  style: TextStyle(
//                    color: Colors.white,
//                  ),
//                  onChanged: (str) {
//
//                  },
//                ),
//              ),
//            ),
