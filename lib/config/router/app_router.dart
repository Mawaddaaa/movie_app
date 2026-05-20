import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../feauters/movies/presentation/screens/movie_details_screen.dart';
import '../../feauters/movies/presentation/screens/movies_list_screen.dart';
import '../../feauters/splash/presentation/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/movies',
      builder: (context, state) => const MoviesListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final movieId = int.parse(state.pathParameters['id']!);
            return MovieDetailsScreen(movieId: movieId);
          },
        ),
      ],
    ),
  ],
);