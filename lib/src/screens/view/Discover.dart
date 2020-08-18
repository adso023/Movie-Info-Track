import 'dart:convert';

import 'package:http/http.dart' as http;
class DiscoverMovie {
  int page;
  List<Movie> results;
  int totalResults;
  int totalPages;
  String statusMessage;
  bool success;
  int statusCode;

  static Map<String, String> paths = {
    "Popular" : "/movie/popular",
    "Top Rated" : "/movie/top_rated",
    "UpComing" : "/movie/upcoming",
    "Now Playing" : "/movie/now_playing"
  };

  DiscoverMovie({this.page, this.results, this.totalResults, this.totalPages, this.statusCode, this.statusMessage, this.success});

  factory DiscoverMovie.fromResponse(Map<String, dynamic> response) {
    return DiscoverMovie(
      page: int.parse( response['page'].toString()) ?? -1,
      totalPages: int.parse(response['total_pages'].toString()) ?? -1,
      totalResults: int.parse(response['total_results'].toString()) ?? -1,
      success: true,
      results: response['results'].map<Movie>((e) => Movie.fromMap(e)).toList() ?? [],
    );
  }

  factory DiscoverMovie.fromError(Map<String, dynamic> response) {
    return DiscoverMovie(
      success: response['success'] ?? false,
      statusCode: int.parse(response['status_code'].toString()),
      statusMessage: response['status_message']
    );
  }

  static Future<DiscoverMovie> getDiscoverMovie(String type, int page) async{
    String path = paths[type];
    print(path);
    http.Response res = await http.get('https://api.themoviedb.org/3$path?api_key=1eddbb452a6eaaf51e05d89cf99d3ebe&language=en-US&page=$page');
    if(res.statusCode == 200) {
      DiscoverMovie discoverMovie = DiscoverMovie.fromResponse(jsonDecode(res.body));
      return discoverMovie;
    } else {
      DiscoverMovie discoverMovie = DiscoverMovie.fromError(jsonDecode(res.body));
      return discoverMovie;
    }
  }
}

class DiscoverTV {
  static Map<String, String> paths = {
    "Popular" : "/tv/popular",
    "Top Rated" : "/tv/top_rated",
    "On the air" : "/tv/on_the_air",
    "Airing Today" : "/tv/airing_today"
  };
}

class TV {}

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