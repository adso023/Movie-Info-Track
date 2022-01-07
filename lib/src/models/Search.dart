// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_track/src/models/simplified/Movie.dart';
import 'package:movie_track/src/models/simplified/Tv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Search {
  int? page;
  List<Movie>? movieResults;
  List<TV>? tvResults;
  int? total_results;
  int? total_pages;

  Search(
      {this.page,
      this.movieResults,
      this.tvResults,
      this.total_pages,
      this.total_results});

  factory Search.forMovie(Map<String, dynamic>? response) {
    return Search();
  }

  factory Search.forTv(Map<String, dynamic> response) {
    return Search();
  }

  static Future<Search?> getSearcForMovie() async {
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=${dotenv.env['API_KEY']}&language=en-US&query=Batman&page=1&include_adult=true"));
    if (res.statusCode == 200) {
      Search searchMovie = Search.forMovie(jsonDecode(res.body));
      return searchMovie;
    }
  }
}
