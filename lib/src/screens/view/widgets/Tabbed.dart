import 'package:flutter/material.dart';

class TabbedMainView extends StatelessWidget {
  final List<String>? titles;
  final List<Widget>? views;

  TabbedMainView({this.titles, this.views});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: this.titles!.length,
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
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              indicator: UnderlineTabIndicator(
                insets: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              ),
              tabs: titles!
                  .map((e) => Tab(
                        child: Text(e),
                      ))
                  .toList(),
            ),
          ),
          preferredSize: Size.fromHeight(5000),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: views!,
        ),
      ),
    );
  }
}
