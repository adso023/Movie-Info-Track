import 'package:flutter/material.dart';

class TabbedMainView extends StatelessWidget {

  final List<String> titles;
  final List<Widget> views;

  TabbedMainView({this.titles, this.views});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            height: 90.0,
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            padding: EdgeInsets.only(top: 20),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white24,
              labelStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500
              ),
              tabs: titles.map((e) => Tab(text: e,)).toList(),
            ),
          ),
          preferredSize: Size.fromHeight(5000),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: views,
        ),
      ),
    );
  }
}