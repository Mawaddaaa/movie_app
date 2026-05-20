import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.voteAverage,
    required super.releaseDate,
    super.genres,
    super.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // genres ka list of objects zay [{"id":28,"name":"Action"}]
    final genreList = (json['genres'] as List<dynamic>?)
        ?.map((g) => g['name'].toString())
        .toList() ??
        [];

    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      genres: genreList,
      runtime: json['runtime'],
    );
  }
}