import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_track/src/about/about.dart';
import 'package:movie_track/src/models/expanded/InfoDiscover.dart';
import 'package:movie_track/src/screens/info/MovieInfoView.dart';
import 'package:movie_track/src/screens/info/TvInfoView.dart';

class Info extends StatefulWidget {
  final String id;
  final bool type;
  Info({required this.id, required this.type});
  createState() => _Info();
}

class _Info extends State<Info> {
  late Future<InfoDiscover?> info;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    info = widget.type
        ? InfoDiscover.getMovieInformation(widget.id)
        : InfoDiscover.getTvInformation(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
              onPressed: () {
                About.showApplicationAboutDialog(context);
              },
              icon: Icon(Icons.info))
        ],
      ),
      body: FutureBuilder<InfoDiscover?>(
        future: info,
        builder: (context, data) {
          if (data.hasData) {
            return buildBody(context, data.data!);
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, InfoDiscover e) {
    return widget.type
        ? MovieInfoView(
            id: e.movieDetails!.id.toString(),
            info: e.movieDetails,
          )
        : TvInfoView(
            id: e.tvDetails!.id.toString(),
            info: e.tvDetails,
          );
  }
}
