
class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<String> genres;
  final int? runtime;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.genres = const [],
    this.runtime,
  });

  // llel soora kamla
  String get fullPosterUrl =>
      'https://image.tmdb.org/t/p/w500$posterPath';

  String get fullBackdropUrl =>
      'https://image.tmdb.org/t/p/w780$backdropPath';

  // runtime bsee8a "2h 15m"
  String get formattedRuntime {
    if (runtime == null) return '';
    final h = runtime! ~/ 60;
    final m = runtime! % 60;
    return '${h}h ${m}m';
  }

  // rating
  double get starsRating => voteAverage / 2;
}