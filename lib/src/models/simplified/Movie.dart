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

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.video,
    this.voteCount});

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