// ignore_for_file: non_constant_identifier_names, unused_field, private_optional_parameter

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SeasonDiscover {
  late String hashId;
  late String air_date;
  late List<SeasonEpisode> episodes;
  late String name;
  late String overview;
  late int id;
  String? poster_path;
  late int season_number;

  SeasonDiscover(
      {required this.hashId,
      required this.air_date,
      required this.episodes,
      required this.id,
      required this.name,
      required this.overview,
      this.poster_path,
      required this.season_number});

  factory SeasonDiscover.fromDynamic(Map<String, dynamic> json) =>
      SeasonDiscover(
          hashId: json['_id'].toString(),
          air_date: json['air_date'].toString(),
          episodes: json['episodes']
              .map<SeasonEpisode>((e) => SeasonEpisode.fromDynamic(e))
              .toList(),
          id: int.parse(json['id'].toString()),
          name: json['name'].toString(),
          overview: json['overview'].toString(),
          poster_path: json['poster_path'].toString(),
          season_number: int.parse(json['season_number'].toString()));

  static Future<SeasonDiscover?> getSeasonInformation(
      int tv_id, int season_number) async {
    http.Response res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/$tv_id/season/$season_number?api_key=${dotenv.env['API_KEY']}&language=en-US"));
    if (res.statusCode == 200) {
      return SeasonDiscover.fromDynamic(jsonDecode(res.body));
    }
  }
}

class SeasonEpisode {
  late String air_date;
  late int episode_number;
  late List<SeasonEpisodeCrew> crew;
  late List<SeasonEpisodeGuestStars> guest_stars;
  late int id;
  late String name;
  late String overview;
  late String production_code;
  late int season_number;
  late String still_path;
  late double vote_average;
  late int vote_count;

  SeasonEpisode(
      {required this.air_date,
      required this.crew,
      required this.episode_number,
      required this.guest_stars,
      required this.id,
      required this.name,
      required this.overview,
      required this.production_code,
      required this.season_number,
      required this.still_path,
      required this.vote_average,
      required this.vote_count});

  factory SeasonEpisode.fromDynamic(Map<String, dynamic> json) => SeasonEpisode(
      air_date: json['air_date'].toString(),
      crew: json['crew']
          .map<SeasonEpisodeCrew>((e) => SeasonEpisodeCrew.fromDynamic(e))
          .toList(),
      episode_number: int.parse(json['episode_number'].toString()),
      guest_stars: json['guest_stars']
          .map<SeasonEpisodeGuestStars>(
              (e) => SeasonEpisodeGuestStars.fromDynamic(e))
          .toList(),
      id: int.parse(json['id'].toString()),
      name: json['name'].toString(),
      overview: json['overview'].toString(),
      production_code: json['production_code'].toString(),
      season_number: int.parse(json['season_number'].toString()),
      still_path: json['still_path'].toString(),
      vote_average: double.parse(json['vote_average'].toString()),
      vote_count: int.parse(json['vote_count'].toString()));
}

class SeasonEpisodeCrew {
  late String department;
  late String job;
  late String credit_id;
  bool? adult;
  late int gender;
  late int id;
  late String known_for_department;
  late String name;
  late String original_name;
  late double popularity;
  String? profile_path;

  SeasonEpisodeCrew(
      {this.adult,
      required this.credit_id,
      required this.department,
      required this.gender,
      required this.id,
      required this.job,
      required this.known_for_department,
      required this.name,
      required this.original_name,
      required this.popularity,
      this.profile_path});

  factory SeasonEpisodeCrew.fromDynamic(Map<String, dynamic> json) =>
      SeasonEpisodeCrew(
          credit_id: json['credit_id'].toString(),
          department: json['department'].toString(),
          gender: int.parse(json['gender'].toString()),
          id: int.parse(json['id'].toString()),
          job: json['job'].toString(),
          known_for_department: json['known_for_department'].toString(),
          name: json['name'].toString(),
          original_name: json['original_name'].toString(),
          popularity: double.parse(json['popularity'].toString()));
}

class SeasonEpisodeGuestStars {
  late String credit_id;
  late int order;
  late String character;
  late bool adult;
  int? gender;
  late int id;
  late String known_for_department;
  late String name;
  late String original_name;
  late double popularity;
  String? profile_path;

  SeasonEpisodeGuestStars(
      {required this.adult,
      required this.character,
      required this.credit_id,
      this.gender,
      required this.id,
      required this.known_for_department,
      required this.name,
      required this.original_name,
      required this.popularity,
      required this.order,
      this.profile_path});

  factory SeasonEpisodeGuestStars.fromDynamic(Map<String, dynamic> json) =>
      SeasonEpisodeGuestStars(
          adult: json['adult'],
          character: json['character'].toString(),
          credit_id: json['credit_id'].toString(),
          gender: int.parse(json['gender'].toString()),
          id: int.parse(json['id'].toString()),
          known_for_department: json['known_for_department'].toString(),
          name: json['name'].toString(),
          order: int.parse(json['order'].toString()),
          original_name: json['original_name'].toString(),
          popularity: double.parse(json['popularity'].toString()),
          profile_path: json['profile_path'].toString());
}
