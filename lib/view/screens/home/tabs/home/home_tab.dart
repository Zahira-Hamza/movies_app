import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/data/models/categories/category_model.dart';
import 'package:movies_app/data/models/movies/movies_model.dart';
import 'package:movies_app/view_model/movies/movies_cubit.dart';
import 'package:movies_app/view_model/movies/movies_states.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../movie_details/widgets/custom_film_poster.dart';

class HomeTab extends StatefulWidget {
  final int selectedCategoryIndex;
  final ValueChanged<int> onCategoryChanged;

  const HomeTab({
    super.key,
    required this.selectedCategoryIndex,
    required this.onCategoryChanged,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;
  late String _currentGenre;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _currentGenre =
        CategoryModel.categories[widget.selectedCategoryIndex].apiValue;
    _loadInitialData();
  }

  void _loadInitialData() {
    final cubit = context.read<MoviesCubit>();
    if (cubit.state is! MoviesLoaded ||
        (cubit.state as MoviesLoaded).movies.isEmpty) {
      cubit.fetchMovies();
    }
    cubit.fetchMoviesByGenre(_currentGenre);
  }

  @override
  void didUpdateWidget(HomeTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedCategoryIndex != widget.selectedCategoryIndex) {
      final newGenre =
          CategoryModel.categories[widget.selectedCategoryIndex].apiValue;
      if (_currentGenre != newGenre) {
        _currentGenre = newGenre;
        context.read<MoviesCubit>().fetchMoviesByGenre(newGenre);
      }
    }
  }

  void _navigateToMovieDetails(MoviesModel movie, BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.movieDetailsRoute,
      arguments: movie.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size screenSize = MediaQuery.sizeOf(context);

    return SafeArea(
      child: BlocConsumer<MoviesCubit, MoviesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoviesError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is MoviesLoaded) {
            final movies = state.movies;
            final genreMovies = state.moviesByGenre;

            return Stack(
              children: [
                Positioned.fill(
                  child: movies.isNotEmpty
                      ? Image.network(
                          movies[currentIndex].poster ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        )
                      : const SizedBox.shrink(),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenSize.height * 0.05),
                        Center(
                          child: Image.asset("assets/images/available_now.png"),
                        ),
                        const SizedBox(height: 20),
                        if (movies.isNotEmpty)
                          CarouselSlider(
                            items: movies.map((movie) {
                              return GestureDetector(
                                onTap: () =>
                                    _navigateToMovieDetails(movie, context),
                                child: CustomFilmPoster(
                                  imagePath: movie.poster ?? '',
                                  rating: (movie.rating ?? 0).toString(),
                                  height: screenSize.height * 0.6,
                                  width: screenSize.width * 0.6,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: screenSize.height * 0.35,
                              enlargeCenterPage: true,
                              viewportFraction: 0.5,
                              enableInfiniteScroll: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                              scrollPhysics: const BouncingScrollPhysics(),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                          ),
                        SizedBox(height: screenSize.height * 0.03),
                        Image.asset("assets/images/watch_now.png"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                CategoryModel
                                    .categories[widget.selectedCategoryIndex]
                                    .name,
                                style: AppStyles.regular16white,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      "see more",
                                      style: AppStyles.regular16white.copyWith(
                                        color: AppColors.yellowPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(width: screenSize.width * 0.01),
                                    Icon(Icons.arrow_forward,
                                        color: AppColors.yellowPrimaryColor),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.28,
                          child: genreMovies.isNotEmpty
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  itemCount: genreMovies.length,
                                  itemBuilder: (context, index) {
                                    final genreMovie = genreMovies[index];
                                    return GestureDetector(
                                      onTap: () => _navigateToMovieDetails(
                                          genreMovie, context),
                                      child: CustomFilmPoster(
                                        imagePath: genreMovie.poster ?? '',
                                        rating:
                                            (genreMovie.rating ?? 0).toString(),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                )
                              : Center(
                                  child: Text(
                                    "No movies found for this category",
                                    style: AppStyles.regular16white,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}