import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_track/src/models/expanded/InfoDiscover.dart';

class MovieInfoView extends StatefulWidget {
  final String id;
  final InfoMovie? info;

  MovieInfoView({required this.id, this.info});

  createState() => _MovieInfoViewState();
}

class _MovieInfoViewState extends State<MovieInfoView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = Duration(milliseconds: 500);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height / 2,
          child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl:
                  'https://image.tmdb.org/t/p/w500${widget.info!.poster_path}',
              progressIndicatorBuilder: (context, str, progress) => Container(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
              errorWidget: (context, str, error) => Container(
                    child: Icon(Icons.tv),
                  )),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            tileColor: Colors.blue,
            title: Text(
              widget.info!.original_title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0),
            ),
            subtitle: Text(
              widget.info!.release_date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) {
                    if (widget.info!.overview == null) {
                      return Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'No Overview Provided',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      );
                    }
                    return Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          children: [
                            Text(
                              'Movie Description',
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.info!.overview!,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ));
                  });
            },
            title: Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) {
                    return Container(
                      color: Colors.black87,
                      padding: const EdgeInsets.all(20),
                      child: FutureBuilder<CastInformation?>(
                        future: CastInformation.getCastInformation(
                            int.parse(widget.id)),
                        builder: (context, data) {
                          if (data.hasData) {
                            return GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 0.56,
                              physics: BouncingScrollPhysics(),
                              children: data.data!.cast
                                  .map<Widget>((e) => GestureDetector(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w185${e.profile_path}',
                                              progressIndicatorBuilder:
                                                  (context, str, progress) =>
                                                      Container(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: progress.progress,
                                                ),
                                              ),
                                              errorWidget: (context, str, _) =>
                                                  Container(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              e.original_name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              e.character,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        onTap: () async {},
                                      ))
                                  .toList(),
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    );
                  });
            },
            title: Text(
              'Cast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.black87,
                        child: ListView(
                          children: [
                            Container(
                              child: Text(
                                'Images',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Not Implemented Yet',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ));
            },
            title: Text(
              'Images',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) => Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                                Container(
                                  child: Text(
                                    'Genres',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ] +
                              widget.info!.genres!
                                  .map<Widget>((e) => ListTile(
                                        title: Text(
                                          e.name,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ))
                                  .toList(),
                        ),
                      ));
            },
            title: Text(
              'Genres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.black87,
                        child: ListView(
                          children: [
                            Container(
                              child: Text(
                                'Movie Metadata',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Not Implemented Yet',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ));
            },
            title: Text(
              'Metadata',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.black87,
                        child: ListView(
                          children: <Widget>[
                                Container(
                                  child: Text(
                                    'Production Companies',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ] +
                              widget.info!.production_companies
                                  .map<Widget>(
                                    (e) => ListTile(
                                      leading: CachedNetworkImage(
                                        height: 100,
                                        width: 70,
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500${e.logo_path}',
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
                                      title: Text(
                                        e.name,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      subtitle: Text(e.origin_country,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white)),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ));
            },
            title: Text(
              'Production Companies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.black87,
                        child: ListView(
                          children: <Widget>[
                                Container(
                                  child: Text(
                                    'Production Countries',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ] +
                              widget.info!.production_countries
                                  .map<Widget>((e) => ListTile(
                                        title: Text(e.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ))
                                  .toList(),
                        ),
                      ));
            },
            title: Text(
              'Production Countries',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
          alignment: Alignment.centerLeft,
          child: ListTile(
            tileColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  transitionAnimationController: controller,
                  builder: (context) => Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          children: <Widget>[
                                Container(
                                  child: Text(
                                    'Spoken Languages',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ] +
                              widget.info!.spoken_languages
                                  .map((e) => ListTile(
                                        title: Text(
                                          e.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ))
                                  .toList(),
                        ),
                      ));
            },
            title: Text(
              'Spoken Languages',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Click for more details'),
          ),
        )
      ],
    );
  }
}
