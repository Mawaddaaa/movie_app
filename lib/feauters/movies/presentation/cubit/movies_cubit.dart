import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feauters/movies/data/repositories/movies_repository.dart';
import 'package:movie_app/feauters/movies/presentation/cubit/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState>{
  final MoviesRepository repository;
  MoviesCubit(this.repository) : super(MoviesInitialState());

  Future<void> fetchPopularMovies() async{
    emit(MoviesLoadingState());
    try{
      final movies = await repository.getPopularMovies();
      emit(MoviesSuccessState(movies));
    }catch(e){
      emit(MoviesErrorState(e.toString()));
    }
  }

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MoviesLoadingState());
    try {
      final movie = await repository.getMovieDetails(movieId);
      emit(MovieDetailLoaded(movie));
    } catch (e) {
      emit(MoviesErrorState(e.toString()));
    }
  }
}

