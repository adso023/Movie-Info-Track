import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_track/src/screens/search/SearchView.dart';

class MainView extends StatefulWidget {
  createState() => _MainView();
}

class _MainView extends State<MainView> {
  String selected;
  var types = <String>["Popular", "Top Rated", "On the air", "Airing Today"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = types[0];
  }

  @override
  Widget build(BuildContext context) {
    List<int> dropDownWidgets = [];
    for(int i = 2000; i <= DateTime.now().year; i++) {
      dropDownWidgets.add(i);
    }
    dropDownWidgets =  dropDownWidgets.reversed.toList();

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
              actions: [
                FlatButton(
                  onPressed: () async{
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.black87.withOpacity(0.5),
                      builder: (context) => AlertDialog(
                        titlePadding: EdgeInsets.zero,
                        title: Text('Filter', style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500,
                        ),),
                        contentPadding: EdgeInsets.zero,
                        content: ListView.separated(
                          itemCount: dropDownWidgets.length,
                          itemBuilder: (context, index) => Container(
                            child: Material(
                              color: Colors.black12,
                              child: ListTile(
                                title: Text('${dropDownWidgets[index]}', style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.white,
                          ),
                        ),
                        elevation: 0.0,
                        backgroundColor: Colors.black12,
                      )
                    );
                  },
                  child: Icon(Icons.filter_list, color: Colors.white,),
                ),
                DropdownButton<String>(
                  items: types
                    .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text('$e', style: TextStyle(color: Colors.white),)))
                      .toList(),
                  value: selected,
                  onChanged: (str) {
                    setState(() {
                      selected = str;
                    });
                  },
                  underline: Container(),
                  dropdownColor: Colors.black,
                  elevation: 10,
                ),
                FlatButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchView(),
                  )),
                  child: Icon(Icons.search, color: Colors.white,)
                )
              ],
            ),
          ),
          Positioned(
            top: 85,
            left: 0,
            right: 0,
            child: SliverGrid(
              delegate: SliverChildListDelegate(
                <Widget>[],
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
              ),
            )
          )
        ],
      ),
    );
  }
}