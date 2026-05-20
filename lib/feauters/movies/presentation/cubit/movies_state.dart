import '../../data/models/movie_model.dart';
import '../../domain/entities/movie_entity.dart';

abstract class MoviesState{}

class MoviesInitialState extends MoviesState{}

class MoviesLoadingState extends MoviesState{}

class MoviesSuccessState extends MoviesState{
  final List<MovieModel> movies;
  MoviesSuccessState(this.movies);
}

class MoviesErrorState extends MoviesState{
  final String error;
  MoviesErrorState(this.error);
}

class MovieDetailLoaded extends MoviesState {
  final MovieEntity movie;
  MovieDetailLoaded(this.movie);
}