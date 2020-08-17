import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
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
              leading: FlatButton(
                onPressed: () {
                  if(Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Icon(Icons.arrow_back, color: Colors.white,),
              ),
              title: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search movies...',
                  hintStyle: TextStyle(color: Colors.white)
                ),
                style: TextStyle(color: Colors.white),
              ),
            )
          ),
          Positioned(
            top: 65,
            left: 0,
            right: 0,
            child: Container(),
          )
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