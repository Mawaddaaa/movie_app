import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/movies_cubit.dart';
import '../cubit/movies_state.dart';
import '../../data/repositories/movies_repository.dart';
import '../widgets/movie_detials_header.dart';
import '../widgets/movie_overview.dart';
import '../widgets/movies_error.dart';
import '../widgets/movies_loading.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late final MoviesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MoviesCubit(MoviesRepository());
    cubit.fetchMovieDetails(widget.movieId);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: Colors.grey[950],
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => context.go('/movies'),
          ),
        ),
        body: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoadingState) return const MoviesLoading();
            if (state is MoviesErrorState) return MoviesError(message: state.error);
            if (state is MovieDetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailsHeader(movie: state.movie),
                    const SizedBox(height: 20),
                    MovieOverview(movie: state.movie),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}