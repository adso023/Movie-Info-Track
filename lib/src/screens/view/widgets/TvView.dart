import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_track/src/screens/search/SearchView.dart';
import 'package:movie_track/src/screens/view/Discover.dart';

class TvView extends StatefulWidget {
  createState() => _TvView();
}

class _TvView extends State<TvView> {
  List<String> types = ["Popular", "Top Rated", "On the air", "Airing Today"];
  String _selectedPath;
  int _currPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPath = types[0];
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
              color: Colors.black87,
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
          child: Container(
            color: Colors.black,
            child: FutureBuilder<Discover>(
              future: Discover.getDiscoverTV(_selectedPath, _currPage),
              builder: (context, data) {
                if(data.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height-45,
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 0.56,
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      physics: BouncingScrollPhysics(),
                      children: data.data.tvResults.map((e) {
                        TV tv = e;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500${e.posterPath}',
                              fit: BoxFit.fill,
                              progressIndicatorBuilder: (context, str, progress) => Container(
                                child: CircularProgressIndicator(value: progress.progress,),
                              ),
                              errorWidget: (context, str, _) => Container(
                                child: Icon(Icons.tv),
                              ),
                            ),
                            Text(tv.name, overflow: TextOverflow.ellipsis, style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400
                            ),),
                            Text(DateTime.parse(tv.firstAirDate).year.toString(), style: TextStyle(
                              fontSize: 10.0, color: Colors.white,
                            ),)
                          ],
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
                border: BorderDirectional(
                    top: BorderSide(color: Colors.white)
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back, color: Colors.white,),
                  onTap: (){},
                ),
                Text('1/1000', style: TextStyle(color: Colors.white),),
                GestureDetector(
                  child: Icon(Icons.arrow_forward, color: Colors.white,),
                  onTap: (){},
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}