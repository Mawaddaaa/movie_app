import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_constants.dart';

class MoviesLoading extends StatelessWidget {
  const MoviesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColor.primaryColor),
    );
  }
}