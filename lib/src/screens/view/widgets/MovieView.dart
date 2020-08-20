import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_track/src/screens/search/Search.dart';
import 'package:movie_track/src/screens/search/SearchView.dart';
import 'package:movie_track/src/screens/view/Discover.dart';

class MovieView extends StatefulWidget {
  createState() => _MovieView();
}

class _MovieView extends State<MovieView> {
  String _selectedPath;
  List<String> types = ["Popular", "Top Rated", "UpComing", "Now Playing"];
  int _currPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPath = 'Popular';
    _currPage = 1;
  }

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
                FlatButton(
                  child: Icon(Icons.filter_list, color: Colors.white,),
                  onPressed: null,
                ),
                DropdownButton<String>(
                  items: types.map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e, style: TextStyle(
                          color: Colors.white,
                        ),),
                      )
                  ).toList(),
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
                FlatButton(
                  child: Icon(Icons.search, color: Colors.white,),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchView(),
                  )),
                )
              ],
            ),
          )
        ),
        Positioned(
          top: 48,
          left: 0,
          right: 0,
          bottom: 45,
          child: FutureBuilder<Discover>(
            future: Discover.getDiscoverMovie(_selectedPath, _currPage),
            builder: (context, data) {
              if(data.hasData && data.data.success) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 45,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 0.56,
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    physics: BouncingScrollPhysics(),
                    children: data.data.movieResults.map<Widget>((e) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: 'https://image.tmdb.org/t/p/w500${e.posterPath}',
                            progressIndicatorBuilder: (context, str, progress) => Container(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            errorWidget: (context, str, _) => Container(
                              child: Icon(Icons.tv),
                            ),
                          ),
                          Text(e.title, overflow: TextOverflow.ellipsis, style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400
                          ),),
                          Text(DateTime.parse(e.releaseDate).year.toString(), style: TextStyle(
                            fontSize: 10.0, color: Colors.white,
                          ),)
                        ],
                      );
                    }).toList(),
                  ),
                );
              } else if(data.hasData && ! data.data.success) {
                return Center(
                  child: Container(
                    child: Text(data.data.statusMessage, style: TextStyle(color: Colors.white),),
                  ),
                );
              }
              return Center(
                child: LinearProgressIndicator(),
              );
            },
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
              border: BorderDirectional(
                top: BorderSide(color: Colors.white)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back, color: Colors.white,),
                  onTap: _currPage == 1 ? null : () => setState(() { _currPage -= 1; }),
                ),
                Text('$_currPage / 1000', style: TextStyle(color: Colors.white),),
                GestureDetector(
                  child: Icon(Icons.arrow_forward, color: Colors.white,),
                  onTap: _currPage == 1000 ? null : () => setState(() { _currPage += 1; }),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}