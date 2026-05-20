import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import 'package:movie_app/feauters/movies/presentation/widgets/genre_chip.dart';
import '../../domain/entities/movie_entity.dart';

class MovieDetailsHeader extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailsHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: movie.fullBackdropUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: Colors.grey[900]),
            errorWidget: (_, __, ___) => Container(color: Colors.grey[900]),
          ),

          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.grey.shade50,
                ],
                stops: const [0.4, 1.0],
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: movie.fullPosterUrl,
                    width: 90,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Rating + Runtime
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: AppColor.primaryColor, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          if (movie.formattedRuntime.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            const Icon(Icons.access_time,
                                color: Colors.white54, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              movie.formattedRuntime,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Genres
                      if (movie.genres.isNotEmpty)
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: movie.genres
                              .take(3)
                              .map((g) => GenreChip(label: g))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

