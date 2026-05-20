import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import '../cubit/movies_cubit.dart';
import '../cubit/movies_state.dart';
import '../widgets/movie_card.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoviesCubit>().fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[950],
      appBar: AppBar(
        title: const Text('Popular Movies',
            style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
          }
          if (state is MoviesErrorState) {
            return Center(child: Text(state.error,
                style: const TextStyle(color: Colors.red)));
          }
          if (state is MoviesSuccessState) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return GestureDetector(
                  onTap: () => context.go('/movies/${movie.id}'),
                  child: MovieCard(movie: movie),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}