import 'package:flutter/material.dart';

class TvView extends StatefulWidget {
  createState() => _TvView();
}

class _TvView extends State<TvView> {
  List<String> types = ["Popular", "Top Rated", "On the air", "Airing Today"];
  String _selectedPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPath = types[0];
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
                      });
                    },
                    underline: Container(),
                    dropdownColor: Colors.black87,
                    elevation: 10,
                  ),
                  FlatButton(
                    child: Icon(Icons.search, color: Colors.white,),
                    onPressed: null,
                  )
                ],
              ),
            )
        ),
        Positioned(
          top: 48,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black,
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