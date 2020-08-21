import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_track/src/screens/view/widgets/TvView.dart';
class Discover {
  int page;
  List<Movie> movieResults;
  List<TV> tvResults;
  int totalResults;
  int totalPages;
  String statusMessage;
  bool success;
  int statusCode;

  static Map<String, String> moviePaths = {
    "Popular" : "/movie/popular",
    "Top Rated" : "/movie/top_rated",
    "UpComing" : "/movie/upcoming",
    "Now Playing" : "/movie/now_playing"
  };

  static Map<String, String> tvPaths = {
    "Popular" : "/tv/popular",
    "Top Rated" : "/tv/top_rated",
    "On the air" : "/tv/on_the_air",
    "Airing Today" : "/tv/airing_today"
  };

  Discover({this.page, this.movieResults, this.tvResults, this.totalResults, this.totalPages, this.statusCode, this.statusMessage, this.success});

  factory Discover.forMovie(Map<String, dynamic> response) {
    return Discover(
      page: int.parse( response['page'].toString()) ?? -1,
      totalPages: int.parse(response['total_pages'].toString()) ?? -1,
      totalResults: int.parse(response['total_results'].toString()) ?? -1,
      success: true,
      movieResults: response['results'].map<Movie>((e) => Movie.fromMap(e)).toList() ?? [],
      tvResults: [],
    );
  }

  factory Discover.forTV(Map<String, dynamic> response) {
    return Discover(
      page: int.parse(response['page'].toString()) ?? -1,
      totalResults: int.parse(response['total_results'].toString()) ?? -1,
      totalPages: int.parse(response['total_pages'].toString()) ?? -1,
      success: true,
      movieResults: [],
      tvResults: response['results'].map<TV>((e) => TV.fromMap(e)).toList() ?? [],
    );
  }

  factory Discover.fromError(Map<String, dynamic> response) {
    return Discover(
      success: response['success'] ?? false,
      statusCode: int.parse(response['status_code'].toString()),
      statusMessage: response['status_message']
    );
  }

  static Future<Discover> getDiscoverTV(String type, int page) async {
    String path = tvPaths[type];
    print(path);
    http.Response res = await http.get("https://api.themoviedb.org/3$path?api_key=1eddbb452a6eaaf51e05d89cf99d3ebe&language=en-US&page=$page");
    print(json.decode(res.body));
    if(res.statusCode == 200) {
      Discover discoverTV = Discover.forTV(jsonDecode(res.body));
      return discoverTV;
    } else {
      Discover discoverTV = Discover.fromError(jsonDecode(res.body));
      return discoverTV;
    }
  }

  static Future<Discover> getDiscoverMovie(String type, int page) async{
    String path = moviePaths[type];
    print(path);
    http.Response res = await http.get('https://api.themoviedb.org/3$path?api_key=1eddbb452a6eaaf51e05d89cf99d3ebe&language=en-US&page=$page');
    if(res.statusCode == 200) {
      Discover discoverMovie = Discover.forMovie(jsonDecode(res.body));
      return discoverMovie;
    } else {
      Discover discoverMovie = Discover.fromError(jsonDecode(res.body));
      return discoverMovie;
    }
  }
}

class TV {
  String posterPath;
  double popularity;
  int id;
  String backdropPath;
  double voteAverage;
  String overview;
  String firstAirDate;
  List<String> originCountry;
  List<int> genreIds;
  String originalLanguage;
  int voteCount;
  String name;
  String originalName;

  TV({this.posterPath, this.voteCount, this.voteAverage, this.popularity, this.overview, this.originalLanguage, this.id, this.genreIds, this.backdropPath, this.name, this.firstAirDate, this.originalName, this.originCountry});

  factory TV.fromMap(Map<String, dynamic> json) {
    return TV(
      posterPath: json['poster_path'] ?? null,
      popularity: double.parse(json['popularity'].toString()),
      id: int.parse(json['id'].toString()),
      backdropPath: json['backdrop_path'].toString() ?? null,
      voteAverage: double.parse(json['vote_average'].toString()),
      overview: json['overview'].toString(),
      firstAirDate: json['first_air_date'].toString(),
      originCountry: json['origin_country'].map<String>((e) => e.toString()).toList(),
      genreIds: json['genre_ids'].map<int>((e) => int.parse(e.toString())).toList(),
      originalLanguage: json['original_language'].toString(),
      voteCount: int.parse(json['vote_count'].toString()),
      name: json['name'].toString(),
      originalName: json['original_name'].toString(),
    );
  }
}

class Movie {
  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  Movie({this.adult, this.backdropPath, this.genreIds, this.id, this.originalLanguage, this.originalTitle, this.overview, this.popularity, this.posterPath, this.releaseDate, this.title, this.voteAverage, this.video, this.voteCount});

  factory Movie.fromMap(Map<String, dynamic> json) {
    return Movie(
      posterPath: json['poster_path'].toString() ?? null,
      adult: json['adult'],
      overview: json['overview'].toString() ?? null,
      releaseDate: json['release_date'].toString(),
      genreIds: json['genre_ids'].map<int>((e) => int.parse(e.toString())).toList(),
      originalTitle: json['original_title'].toString(),
      originalLanguage: json['original_language'].toString(),
      title: json['title'].toString(),
      backdropPath: json['backdrop_path'].toString() ?? null,
      popularity: double.parse(json['popularity'].toString()),
      voteCount: int.parse(json['vote_count'].toString()),
      video: json['video'],
      voteAverage: double.parse(json['vote_average'].toString()),
    );
  }
}