import 'package:flutter/material.dart';
import '../../domain/entities/movie_entity.dart';
import 'info_row.dart';

class MovieOverview extends StatelessWidget {
  final MovieEntity movie;
  const MovieOverview({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.overview,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          InfoRow(
            icon: Icons.calendar_today,
            label: 'Release Date',
            value: movie.releaseDate,
          ),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.how_to_vote,
            label: 'Rating',
            value: '${movie.voteAverage.toStringAsFixed(1)} / 10',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}