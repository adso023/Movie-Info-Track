class TV {
  String? posterPath;
  double? popularity;
  String id;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? firstAirDate;
  List<String>? originCountry;
  List<int>? genreIds;
  String? originalLanguage;
  int? voteCount;
  String? name;
  String? originalName;

  TV(
      {this.posterPath,
      this.voteCount,
      this.voteAverage,
      this.popularity,
      this.overview,
      this.originalLanguage,
      required this.id,
      this.genreIds,
      this.backdropPath,
      this.name,
      this.firstAirDate,
      this.originalName,
      this.originCountry});

  factory TV.fromMap(Map<String, dynamic> json) {
    return TV(
      posterPath: json['poster_path'] ?? null,
      popularity: double.parse(json['popularity'].toString()),
      id: json['id'].toString(),
      backdropPath: json['backdrop_path'].toString(),
      voteAverage: double.parse(json['vote_average'].toString()),
      overview: json['overview'].toString(),
      firstAirDate: json['first_air_date'].toString(),
      originCountry:
          json['origin_country'].map<String>((e) => e.toString()).toList(),
      genreIds:
          json['genre_ids'].map<int>((e) => int.parse(e.toString())).toList(),
      originalLanguage: json['original_language'].toString(),
      voteCount: int.parse(json['vote_count'].toString()),
      name: json['name'].toString(),
      originalName: json['original_name'].toString(),
    );
  }
}
