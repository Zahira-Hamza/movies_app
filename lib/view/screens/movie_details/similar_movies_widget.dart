// features/movie_details/presentation/widgets/similar_movies_widget.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../data/models/movies/movie_model.dart';

/// ويدجت لعرض الأفلام المشابهة
class SimilarMoviesWidget extends StatelessWidget {
  final List<MovieModel> movies;

  const SimilarMoviesWidget({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox(); // لا تعرض anything إذا كانت القائمة فارغة
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  AppRoutes.navigateToMovieDetails(
                    context,
                    movieId: movie.id,
                    movie: movie,
                  );
                },
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(
                    right: index == movies.length - 1 ? 0 : 12,
                    left: index == 0 ? 0 : 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة الفيلم
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: movie.mediumCoverImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.movie, size: 40),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // عنوان الفيلم
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // السنة والتقييم
                      Text(
                        '${movie.year} • ${movie.rating}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
