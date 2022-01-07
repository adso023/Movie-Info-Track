import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_track/src/models/simplified/Movie.dart';
import 'package:movie_track/src/models/simplified/Tv.dart';

class Discover {
  int? page;
  List<Movie>? movieResults;
  List<TV>? tvResults;
  int? totalResults;
  int? totalPages;
  String? statusMessage;
  bool? success;
  int? statusCode;

  static Map<String, String> moviePaths = {
    "Popular": "/movie/popular",
    "Top Rated": "/movie/top_rated",
    "UpComing": "/movie/upcoming",
    "Now Playing": "/movie/now_playing"
  };

  static Map<String, String> tvPaths = {
    "Popular": "/tv/popular",
    "Top Rated": "/tv/top_rated",
    "On the air": "/tv/on_the_air",
    "Airing Today": "/tv/airing_today"
  };

  Discover(
      {this.page,
      this.movieResults,
      this.tvResults,
      this.totalResults,
      this.totalPages,
      this.statusCode,
      this.statusMessage,
      this.success});

  factory Discover.forMovie(Map<String, dynamic> response) {
    return Discover(
      page: int.parse(response['page'].toString()),
      totalPages: int.parse(response['total_pages'].toString()),
      totalResults: int.parse(response['total_results'].toString()),
      success: true,
      movieResults:
          response['results'].map<Movie>((e) => Movie.fromMap(e)).toList() ??
              [],
      tvResults: [],
    );
  }

  factory Discover.forTV(Map<String, dynamic> response) {
    return Discover(
      page: int.parse(response['page'].toString()),
      totalResults: int.parse(response['total_results'].toString()),
      totalPages: int.parse(response['total_pages'].toString()),
      success: true,
      movieResults: [],
      tvResults:
          response['results'].map<TV>((e) => TV.fromMap(e)).toList() ?? [],
    );
  }

  factory Discover.fromError(Map<String, dynamic> response) {
    return Discover(
        success: response['success'] ?? false,
        statusCode: int.parse(response['status_code'].toString()),
        statusMessage: response['status_message']);
  }

  static Future<Discover> getDiscoverTV(String? type, int? page) async {
    String? path = tvPaths[type!];
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3$path?api_key=${dotenv.env['API_KEY']}&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      Discover discoverTV = Discover.forTV(jsonDecode(res.body));
      return discoverTV;
    } else {
      Discover discoverTV = Discover.fromError(jsonDecode(res.body));
      return discoverTV;
    }
  }

  static Future<Discover> getDiscoverMovie(String? type, int? page) async {
    String? path = moviePaths[type!];
    http.Response res = await http.get(Uri.parse(
        'https://api.themoviedb.org/3$path?api_key=${dotenv.env['API_KEY']}&language=en-US&page=$page'));
    if (res.statusCode == 200) {
      Discover discoverMovie = Discover.forMovie(jsonDecode(res.body));
      return discoverMovie;
    } else {
      Discover discoverMovie = Discover.fromError(jsonDecode(res.body));
      return discoverMovie;
    }
  }
}
