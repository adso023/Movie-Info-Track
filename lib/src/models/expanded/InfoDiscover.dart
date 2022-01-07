// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class InfoDiscover {
  InfoMovie? movieDetails;
  InfoTv? tvDetails;

  InfoDiscover({this.movieDetails, this.tvDetails});

  factory InfoDiscover.forMovie(Map<String, dynamic> response) {
    return InfoDiscover(
      movieDetails: InfoMovie.fromMap(response),
    );
  }

  factory InfoDiscover.forTv(Map<String, dynamic> response) {
    return InfoDiscover(tvDetails: InfoTv.fromMap(response));
  }

  static Future<InfoDiscover?> getMovieInformation(String? movie_id) async {
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$movie_id?api_key=${dotenv.env['API_KEY']}&language=en-US"));
    InfoDiscover id = InfoDiscover.forMovie(jsonDecode(res.body));
    return id;
  }

  static Future<InfoDiscover?> getTvInformation(String? tv_id) async {
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/$tv_id?api_key=${dotenv.env['API_KEY']}&language=en-US"));
    print(jsonDecode(res.body));
    InfoDiscover id = InfoDiscover.forTv(jsonDecode(res.body));
    return id;
  }
}

class InfoMovie {
  late bool adult;
  String? backdrop_path;
  dynamic belongs_to_collection;
  late int budget;
  List<Genre>? genres;
  String? homepage;
  late int id;
  String? imdb;
  late String original_language;
  late String original_title;
  String? overview;
  late double popularity;
  String? poster_path;
  late List<ProductionCompanies> production_companies;
  late List<ProductionCountries> production_countries;
  late String release_date;
  late int revenue;
  int? runtime;
  late List<SpokenLanguages> spoken_languages;
  late String status;
  String? tagline;
  late String title;
  late bool video;
  late double vote_average;
  late int vote_count;

  InfoMovie(
      {required this.adult,
      this.backdrop_path,
      this.belongs_to_collection,
      required this.budget,
      this.genres,
      this.homepage,
      required this.id,
      this.imdb,
      required this.original_language,
      required this.original_title,
      this.overview,
      required this.popularity,
      this.poster_path,
      required this.production_companies,
      required this.production_countries,
      required this.release_date,
      required this.revenue,
      this.runtime,
      required this.spoken_languages,
      required this.status,
      this.tagline,
      required this.title,
      required this.video,
      required this.vote_average,
      required this.vote_count});

  factory InfoMovie.fromMap(Map<String, dynamic> json) {
    return InfoMovie(
        adult: json['adult'],
        backdrop_path: json['backdrop_path'],
        belongs_to_collection: json['belongs_to_collection'],
        budget: int.parse(json['budget'].toString()),
        genres: json['genres'].map<Genre>((e) => Genre.fromDynamic(e)).toList(),
        homepage: json['homepage'].toString(),
        id: json['id'],
        imdb: json['imdb'].toString(),
        original_language: json['original_language'].toString(),
        original_title: json['original_title'].toString(),
        overview: json['overview'].toString(),
        popularity: double.parse(json['popularity'].toString()),
        poster_path: json['poster_path'].toString(),
        production_companies: json['production_companies']
            .map<ProductionCompanies>((e) => ProductionCompanies.fromDynamic(e))
            .toList(),
        production_countries: json['production_countries']
            .map<ProductionCountries>((e) => ProductionCountries.fromDynamic(e))
            .toList(),
        release_date: json['release_date'].toString(),
        revenue: int.parse(json['revenue'].toString()),
        runtime: int.parse(json['runtime'].toString()),
        spoken_languages: json['spoken_languages']
            .map<SpokenLanguages>((e) => SpokenLanguages.fromDynamic(e))
            .toList(),
        status: json['status'].toString(),
        tagline: json['tagline'].toString(),
        title: json['title'].toString(),
        video: json['video'],
        vote_average: double.parse(json['vote_average'].toString()),
        vote_count: int.parse(json['vote_count'].toString()));
  }
}

class Genre {
  late int id;
  late String name;

  Genre({required this.id, required this.name});

  factory Genre.fromDynamic(Map<String, dynamic> json) => Genre(
      id: int.parse(json['id'].toString()), name: json['name'].toString());
}

class ProductionCompanies {
  late String name;
  late int id;
  String? logo_path;
  late String origin_country;

  ProductionCompanies(
      {required this.name,
      required this.id,
      this.logo_path,
      required this.origin_country});

  factory ProductionCompanies.fromDynamic(Map<String, dynamic> json) =>
      ProductionCompanies(
          name: json['name'].toString(),
          id: int.parse(json['id'].toString()),
          logo_path: json['logo_path'].toString(),
          origin_country: json['origin_country'].toString());
}

class ProductionCountries {
  late String iso_3166_1;
  late String name;

  ProductionCountries({required this.iso_3166_1, required this.name});

  factory ProductionCountries.fromDynamic(Map<String, dynamic> json) =>
      ProductionCountries(
          iso_3166_1: json['iso_3166_1'].toString(),
          name: json['name'].toString());
}

class SpokenLanguages {
  late String iso_3166_1;
  late String name;

  SpokenLanguages({required this.iso_3166_1, required this.name});

  factory SpokenLanguages.fromDynamic(Map<String, dynamic> json) =>
      SpokenLanguages(
          iso_3166_1: json['iso_3166_1'].toString(),
          name: json['name'].toString());
}

class InfoTv {
  String? backdrop_path;
  late List<CreatedBy> created_by;
  late List<int> episode_run_time;
  late String first_air_date;
  late List<Genre> genres;
  late String homepage;
  late int id;
  late bool in_production;
  late List<String> languages;
  late String last_air_date;
  late LastEpisodeToAir last_episode_to_air;
  late String name;
  late List<Networks> networks;
  late int number_of_episodes;
  late int number_of_seasons;
  late List<String> origin_country;
  late String original_language;
  late String original_name;
  late String overview;
  late double popularity;
  String? poster_path;
  late List<ProductionCompanies> production_companies;
  late List<ProductionCountries> production_countries;
  late List<Season> seasons;
  late List<SpokenLanguages> spoken_languages;
  late String status;
  late String tagline;
  late String type;
  late double vote_average;
  late double vote_count;

  InfoTv(
      {this.backdrop_path,
      required this.created_by,
      required this.episode_run_time,
      required this.first_air_date,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.in_production,
      required this.languages,
      required this.last_air_date,
      required this.last_episode_to_air,
      required this.name,
      required this.networks,
      required this.number_of_episodes,
      required this.number_of_seasons,
      required this.origin_country,
      required this.original_language,
      required this.original_name,
      required this.overview,
      required this.popularity,
      this.poster_path,
      required this.production_companies,
      required this.production_countries,
      required this.seasons,
      required this.spoken_languages,
      required this.status,
      required this.tagline,
      required this.type,
      required this.vote_average,
      required this.vote_count});

  factory InfoTv.fromMap(Map<String, dynamic> json) => InfoTv(
      backdrop_path: json['backdrop_path'].toString(),
      created_by: json['created_by']
          .map<CreatedBy>((e) => CreatedBy.fromDynamic(e))
          .toList(),
      episode_run_time: json['episode_run_time']
          .map<int>((e) => int.parse(e.toString()))
          .toList(),
      first_air_date: json['first_air_date'].toString(),
      genres: json['genres'].map<Genre>((e) => Genre.fromDynamic(e)).toList(),
      homepage: json['homepage'].toString(),
      id: int.parse(json['id'].toString()),
      in_production: json['in_production'],
      languages: json['languages'].map<String>((e) => e.toString()).toList(),
      last_air_date: json['last_air_date'].toString(),
      last_episode_to_air:
          LastEpisodeToAir.fromDynamic(json['last_episode_to_air']),
      name: json['name'].toString(),
      networks: json['networks']
          .map<Networks>((e) => Networks.fromDynamic(e))
          .toList(),
      number_of_episodes: int.parse(json['number_of_episodes'].toString()),
      number_of_seasons: int.parse(json['number_of_seasons'].toString()),
      origin_country:
          json['origin_country'].map<String>((e) => e.toString()).toList(),
      original_language: json['original_language'].toString(),
      original_name: json['original_name'].toString(),
      overview: json['overview'].toString(),
      poster_path: json['poster_path'].toString(),
      popularity: double.parse(json['popularity'].toString()),
      production_companies: json['production_companies']
          .map<ProductionCompanies>((e) => ProductionCompanies.fromDynamic(e))
          .toList(),
      production_countries: json['production_countries']
          .map<ProductionCountries>((e) => ProductionCountries.fromDynamic(e))
          .toList(),
      seasons:
          json['seasons'].map<Season>((e) => Season.fromDynamic(e)).toList(),
      spoken_languages: json['spoken_languages']
          .map<SpokenLanguages>((e) => SpokenLanguages.fromDynamic(e))
          .toList(),
      status: json['status'].toString(),
      tagline: json['tagline'].toString(),
      type: json['type'].toString(),
      vote_average: double.parse(json['vote_average'].toString()),
      vote_count: double.parse(json['vote_count'].toString()));
}

class CreatedBy {
  late int id;
  late String credit_id;
  late String name;
  late int gender;
  String? profile_path;

  CreatedBy(
      {required this.id,
      required this.credit_id,
      required this.name,
      required this.gender,
      this.profile_path});

  factory CreatedBy.fromDynamic(Map<String, dynamic> json) => CreatedBy(
      id: int.parse(json['id'].toString()),
      credit_id: json['credit_id'].toString(),
      name: json['name'].toString(),
      gender: int.parse(json['gender'].toString()),
      profile_path: json['profile_path'].toString());
}

class LastEpisodeToAir {
  late String air_date;
  late int episode_number;
  late int id;
  late String name;
  late String overview;
  late String production_code;
  late int season_number;
  String? still_path;
  late double vote_average;
  late int vote_count;

  LastEpisodeToAir(
      {required this.air_date,
      required this.episode_number,
      required this.id,
      required this.name,
      required this.overview,
      required this.production_code,
      required this.season_number,
      this.still_path,
      required this.vote_average,
      required this.vote_count});

  factory LastEpisodeToAir.fromDynamic(Map<String, dynamic> json) =>
      LastEpisodeToAir(
          air_date: json['air_date'].toString(),
          episode_number: int.parse(json['episode_number'].toString()),
          id: int.parse(json['id'].toString()),
          name: json['name'].toString(),
          overview: json['overview'].toString(),
          production_code: json['production_code'].toString(),
          season_number: int.parse(json['season_number'].toString()),
          still_path: json['still_path'].toString(),
          vote_average: double.parse(json['vote_average'].toString()),
          vote_count: int.parse(json['vote_count'].toString()));
}

class Networks {
  late String name;
  late int id;
  String? logo_path;
  late String origin_country;

  Networks(
      {required this.name,
      required this.id,
      this.logo_path,
      required this.origin_country});

  factory Networks.fromDynamic(Map<String, dynamic> json) => Networks(
      name: json['name'].toString(),
      id: int.parse(json['id'].toString()),
      logo_path: json['logo_path'].toString(),
      origin_country: json['origin_country'].toString());
}

class Season {
  late String air_date;
  late int episode_count;
  late int id;
  late String name;
  late String overview;
  late String poster_path;
  late int season_number;

  Season(
      {required this.air_date,
      required this.episode_count,
      required this.id,
      required this.name,
      required this.overview,
      required this.poster_path,
      required this.season_number});

  factory Season.fromDynamic(Map<String, dynamic> json) => Season(
      air_date: json['air_date'].toString(),
      episode_count: int.parse(json['episode_count'].toString()),
      id: int.parse(json['id'].toString()),
      name: json['name'].toString(),
      overview: json['overview'].toString(),
      poster_path: json['poster_path'].toString(),
      season_number: int.parse(json['season_number'].toString()));
}

class CastInformation {
  late List<Cast> cast;
  late List<Crew> crew;

  CastInformation({required this.cast, required this.crew});

  factory CastInformation.fromDynamic(Map<String, dynamic> json) =>
      CastInformation(
          cast: json['cast'].map<Cast>((e) => Cast.fromDynamic(e)).toList(),
          crew: json['crew'].map<Crew>((e) => Crew.fromDynamic(e)).toList());

  static Future<CastInformation?> getCastInformation(int movie_id) async {
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$movie_id/credits?api_key=${dotenv.env['API_KEY']}&language=en-US"));
    if (res.statusCode == 200) {
      return CastInformation.fromDynamic(jsonDecode(res.body));
    }
  }

  static Future<CastInformation?> getTvCastInformation(int tv_id) async {
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/$tv_id/credits?api_key=${dotenv.env['API_KEY']}&language=en-US"));
    if (res.statusCode == 200) {
      return CastInformation.fromDynamic(jsonDecode(res.body));
    }
  }
}

class Cast {
  late bool adult;
  int? gender;
  late int id;
  late String known_for_department;
  late String name;
  late String original_name;
  late double popularity;
  String? profile_path;
  late int cast_id;
  late String character;
  late String credit_id;
  late int order;

  Cast(
      {required this.adult,
      this.gender,
      required this.id,
      required this.known_for_department,
      required this.name,
      required this.original_name,
      required this.popularity,
      this.profile_path,
      required this.cast_id,
      required this.character,
      required this.credit_id,
      required this.order});

  factory Cast.fromDynamic(Map<String, dynamic> json) => Cast(
      adult: json['adult'],
      gender: int.parse(json['gender'].toString()),
      id: int.parse(json['id'].toString()),
      known_for_department: json['known_for_department'].toString(),
      name: json['name'].toString(),
      original_name: json['original_name'].toString(),
      popularity: double.parse(json['popularity'].toString()),
      profile_path: json['profile_path'].toString(),
      cast_id:
          json['cast_id'] == null ? -1 : int.parse(json['cast_id'].toString()),
      character: json['character'].toString(),
      credit_id: json['credit_id'].toString(),
      order: int.parse(json['order'].toString()));
}

class Crew {
  late bool adult;
  int? gender;
  late int id;
  late String known_for_department;
  late String name;
  late String original_name;
  late double popularity;
  String? profile_path;
  late String credit_id;
  late String department;
  late String job;

  Crew(
      {required this.adult,
      this.gender,
      required this.id,
      required this.known_for_department,
      required this.name,
      required this.original_name,
      required this.popularity,
      this.profile_path,
      required this.department,
      required this.credit_id,
      required this.job});

  factory Crew.fromDynamic(Map<String, dynamic> json) => Crew(
      adult: json['adult'],
      gender: int.parse(json['gender'].toString()),
      id: int.parse(json['id'].toString()),
      known_for_department: json['known_for_department'].toString(),
      name: json['name'].toString(),
      original_name: json['original_name'].toString(),
      popularity: double.parse(json['popularity'].toString()),
      profile_path: json['profile_path'].toString(),
      department: json['department'].toString(),
      credit_id: json['credit_id'].toString(),
      job: json['job'].toString());
}

class ImageInformation {
  late List<BackdropPoster> backdrops;
  late List<BackdropPoster> posters;

  ImageInformation({required this.backdrops, required this.posters});

  factory ImageInformation.fromDynamic(Map<String, dynamic> json) =>
      ImageInformation(
          backdrops: json['backdrops']
              .map<BackdropPoster>((e) => BackdropPoster.fromDynamic(e))
              .toList(),
          posters: json['posters']
              .map<BackdropPoster>((e) => BackdropPoster.fromDynamic(e))
              .toList());

  static Future<ImageInformation?> getImages(String movie_id) async {
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$movie_id/images?api_key=${dotenv.env['API_KEY']}&language=en-US"));
    if (res.statusCode == 200) {
      return ImageInformation.fromDynamic(jsonDecode(res.body));
    }
  }
}

class BackdropPoster {
  late double aspect_ratio;
  late String file_path;
  late int height;
  String? iso_639_1;
  late int vote_average;
  late int vote_count;
  late int width;

  BackdropPoster(
      {required this.aspect_ratio,
      required this.file_path,
      required this.height,
      this.iso_639_1,
      required this.vote_average,
      required this.vote_count,
      required this.width});

  factory BackdropPoster.fromDynamic(Map<String, dynamic> json) =>
      BackdropPoster(
          aspect_ratio: double.parse(json['aspect_ratio'].toString()),
          file_path: json['file_path'].toString(),
          height: int.parse(json['height'].toString()),
          vote_average: int.parse(json['vote_average'].toString()),
          vote_count: int.parse(json['vote_count'].toString()),
          width: int.parse(json['width'].toString()));
}
