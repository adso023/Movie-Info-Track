import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  final int id;
  final bool type;
  Info({this.id, this.type});
  createState() => _Info();
}

class _Info extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, data) {
          return ListView(
            children: widget.type ? buildMovieChildren() : buildTvChildren()
          );
        },
    );
  }

  Widget buildBody() {
    return Container();
  }

  List<Widget> buildMovieChildren() {
    return [];
  }

  List<Widget> buildTvChildren() {
    return [];
  }
}