import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About {
  static void showApplicationAboutDialog(BuildContext context) {
    showAboutDialog(
        context: context,
        applicationName: 'Movie Info Track',
        applicationVersion: '1.0.0',
        children: <Widget>[
          Container(
              child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text:
                      "All film-related metadata used in Letterboxd, including actor, director and studio names, synopses, release dates, trailers and poster art is supplied by ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black)),
              TextSpan(
                  text: "The Movie Database ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                  mouseCursor: SystemMouseCursors.precise,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://www.themoviedb.org/');
                    }),
              TextSpan(
                  text: '(TMDb)',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black)),
            ]),
          )),
          Image(
              image: AssetImage(
            "assets/tmdb-attr.png",
          )),
          Text(
            'Movie-Info-Track uses the TMDb API but is not endorsed or certified by TMDB',
            style: TextStyle(fontStyle: FontStyle.italic),
          )
        ]);
  }
}
