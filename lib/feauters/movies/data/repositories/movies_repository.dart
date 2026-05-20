import 'dart:async';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/feauters/movies/data/models/movie_model.dart';

class MoviesRepository {
  final Dio dio = DioClient.instance;

  Future<List<MovieModel>> getPopularMovies() async{
    final response = await dio.get(ApiConstants.popularMovies);
    final List results = response.data['results'];
    return results.map((e)=> MovieModel.fromJson(e)).toList();
  }

  Future<MovieModel> getMovieDetails(int movieId) async{
    final response = await dio.get('${ApiConstants.movieDetail}/$movieId');
    return MovieModel.fromJson(response.data);
  }
}