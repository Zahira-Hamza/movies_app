import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/models/movies/movie_basic_info.dart';
import 'package:movies_app/view/screens/movie_details/movie_details_page.dart';
import 'package:movies_app/view/widgets/movies/custom_film_poster.dart';

class FavOrHistoryMovies extends StatelessWidget {
  const FavOrHistoryMovies({super.key, required this.movies});

  final List<MovieBasicInfo> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 122 / 180,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      itemCount: movies.length,
      itemBuilder: (context, index) => CustomFilmPoster(
          imagePath: movies[index].imageUrl,
          rating: movies[index].rating.toString(),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailsPage(
                      movieId: int.parse(movies[index].movieId)),
                ),);

          }),
    );
  }
}
