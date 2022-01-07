import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_track/src/about/about.dart';
import 'package:movie_track/src/models/simplified/Discover.dart';
import 'package:movie_track/src/models/simplified/Tv.dart';
import 'package:movie_track/src/screens/info/Info.dart';
import 'package:movie_track/src/screens/search/SearchView.dart';

class TvView extends StatefulWidget {
  createState() => _TvView();
}

class _TvView extends State<TvView> {
  List<String> types = ["Popular", "Top Rated", "On the air", "Airing Today"];
  String? _selectedPath;
  int _currPage = 0;
  ScrollController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPath = types[0];
    _currPage = 1;
    _controller = ScrollController();
  }

  void toTop() => _controller!.jumpTo(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black87,
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      About.showApplicationAboutDialog(context);
                    },
                  ),
                  DropdownButton<String>(
                    items: types
                        .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                        .toList(),
                    value: _selectedPath,
                    onChanged: (str) {
                      setState(() {
                        _selectedPath = str;
                        _currPage = 1;
                      });
                    },
                    underline: Container(),
                    dropdownColor: Colors.black87,
                    elevation: 10,
                  ),
                  TextButton(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchView(),
                        )),
                  )
                ],
              ),
            )),
        Positioned(
          top: 48,
          left: 0,
          right: 0,
          bottom: 45,
          child: Container(
            color: Colors.black,
            child: FutureBuilder<Discover>(
              future: Discover.getDiscoverTV(_selectedPath, _currPage),
              builder: (context, data) {
                if (data.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 45,
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 0.56,
                      controller: _controller,
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      physics: BouncingScrollPhysics(),
                      children: data.data!.tvResults!.map((e) {
                        return GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${e.posterPath}',
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, str, progress) => Container(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                  ),
                                ),
                                errorWidget: (context, str, _) => Container(
                                  child: Icon(Icons.tv),
                                ),
                              ),
                              Text(
                                e.name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                DateTime.parse(e.firstAirDate!).year.toString(),
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          onTap: () async {
                            print({e.id, e.name});
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Info(
                                          id: e.id,
                                          type: false,
                                        )));
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
                return Center(
                  child: LinearProgressIndicator(),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 45.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black26,
                border:
                    BorderDirectional(top: BorderSide(color: Colors.white))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onTap: _currPage == 1
                      ? null
                      : () => setState(() {
                            _currPage -= 1;
                            toTop();
                          }),
                ),
                Text(
                  '$_currPage/1000',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onTap: _currPage == 1000
                      ? null
                      : () => setState(() {
                            _currPage += 1;
                            toTop();
                          }),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
