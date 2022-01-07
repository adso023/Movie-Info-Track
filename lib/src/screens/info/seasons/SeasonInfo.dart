// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_track/src/about/about.dart';
import 'package:movie_track/src/models/expanded/InfoDiscover.dart';
import 'package:movie_track/src/models/expanded/SeasonDiscover.dart';

class SeasonInfo extends StatefulWidget {
  final String tv_id;
  final List<Season> seasons;
  final int season_selected;

  SeasonInfo({
    required this.tv_id,
    required this.seasons,
    required this.season_selected,
  });

  createState() => _SeasonInfo();
}

class _SeasonInfo extends State<SeasonInfo> {
  late int _seasonSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _seasonSelected = widget.season_selected;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        body: FutureBuilder<SeasonDiscover?>(
          future: SeasonDiscover.getSeasonInformation(
              int.parse(widget.tv_id), _seasonSelected),
          builder: (context, data) {
            if (data.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[
                        Container(
                          child: CachedNetworkImage(
                            height: MediaQuery.of(context).size.height / 2,
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${data.data!.poster_path}',
                            progressIndicatorBuilder:
                                (context, str, progress) => Container(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            errorWidget: (context, str, err) => Container(
                              child: Icon(Icons.tv),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 20),
                          child: Container(
                              child: Column(
                            children: [
                              DropdownButton(
                                  value: _seasonSelected,
                                  hint: Text(
                                    'Season #',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  items: widget.seasons
                                      .map<DropdownMenuItem<int>>(
                                          (e) => DropdownMenuItem(
                                              value: e.season_number,
                                              child: Text(
                                                'Season ${e.season_number}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )))
                                      .toList(),
                                  onChanged: (int? selected) {
                                    setState(() {
                                      _seasonSelected = selected!;
                                    });
                                  }),
                              Text(
                                'Click on episode for more information',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 14.0),
                              ),
                            ],
                          )),
                        )
                      ] +
                      data.data!.episodes
                          .map<Widget>((e) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500${e.still_path}',
                                        progressIndicatorBuilder:
                                            (context, str, progress) =>
                                                Container(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                        errorWidget: (context, str, _) =>
                                            Container(
                                          child: Icon(Icons.tv),
                                        ),
                                      ),
                                      Text(
                                        e.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        e.air_date.toString(),
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      Text(
                                        e.overview,
                                        style: TextStyle(fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                  onTap: () async {
                                    await showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                            color: Colors.black87,
                                            padding: const EdgeInsets.all(20),
                                            child: ListView(
                                              children: <Widget>[
                                                    TextButton.icon(
                                                        onPressed: () {},
                                                        icon: Icon(Icons.info),
                                                        label: Text(
                                                            'More information about episode')),
                                                    Container(
                                                      child: Text(
                                                        'Guest Stars',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ] +
                                                  e.guest_stars
                                                      .map<Widget>((e) {
                                                    return ListTile(
                                                      leading:
                                                          CachedNetworkImage(
                                                        imageUrl:
                                                            'https://image.tmdb.org/t/p/w500${e.profile_path}',
                                                        progressIndicatorBuilder:
                                                            (context, str,
                                                                    progress) =>
                                                                Container(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: progress
                                                                .progress,
                                                          ),
                                                        ),
                                                        errorWidget:
                                                            (context, str, _) =>
                                                                Container(
                                                          child: Icon(
                                                              Icons.person),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        e.original_name,
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      subtitle: Text(
                                                        e.character,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0),
                                                      ),
                                                    );
                                                  }).toList(),
                                            )));
                                  },
                                ),
                              ))
                          .toList(),
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
