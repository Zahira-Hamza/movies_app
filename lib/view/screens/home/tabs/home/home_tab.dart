import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/data/data_sources/remote_data_source.dart';
import 'package:movies_app/view/widgets/film_poster/custom_film_poster.dart';
import 'package:movies_app/data/models/categories/category_model.dart';

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

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  late Future<List<Map<String, dynamic>>> futureMovies;
  late Future<List<Map<String, dynamic>>> futureMoviesByGenre;

  @override
  void initState() {
    super.initState();
    futureMovies = RemoteDataSource().fetchMovies();
    final initialGenre = CategoryModel.categories[widget.selectedCategoryIndex].apiValue;
    futureMoviesByGenre = RemoteDataSource().fetchMovies(genre: initialGenre);
  }

  void _loadMoviesForCategory(String genre) {
    setState(() {
      futureMoviesByGenre = RemoteDataSource().fetchMovies(genre: genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No movies found"));
          }

          final movies = snapshot.data!;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  movies[currentIndex]['medium_cover_image'] ?? '',
                  fit: BoxFit.fill,
                ),
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
                      CarouselSlider(
                        items: movies.map((movie) {
                          return CustomFilmPoster(
                            imagePath: movie['medium_cover_image'] ?? '',
                            rating: (movie['rating'] ?? 0).toString(),
                            height: screenSize.height * 0.6,
                            width: screenSize.width * 0.6,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: screenSize.height * 0.35,
                          enlargeCenterPage: true,
                          viewportFraction: 0.5,
                          enableInfiniteScroll: true,
                          initialPage: 0,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          scrollPhysics: const BouncingScrollPhysics(),
                          enlargeFactor: 0.36,
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
                                  .categories[widget.selectedCategoryIndex].name,
                              style: AppStyles.regular16white,
                            ),
                            TextButton(
                              onPressed: () {
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "see more",
                                    style: AppStyles.regular16white.copyWith(
                                        color: AppColors.yellowPrimaryColor),
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
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: futureMoviesByGenre,
                        builder: (context, genreSnapshot) {
                          if (genreSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (genreSnapshot.hasError) {
                            return Center(
                                child:
                                Text("Error: ${genreSnapshot.error}"));
                          } else if (!genreSnapshot.hasData ||
                              genreSnapshot.data!.isEmpty) {
                            return const Center(child: Text("No movies found"));
                          }

                          final genreMovies = genreSnapshot.data!;
                          return SizedBox(
                            height: screenSize.height * 0.28,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8),
                              itemCount: genreMovies.length,
                              itemBuilder: (context, index) {
                                return CustomFilmPoster(
                                  imagePath:
                                  genreMovies[index]['medium_cover_image'] ??
                                      '',
                                  rating:
                                  (genreMovies[index]['rating'] ?? 0)
                                      .toString(),
                                );
                              },
                              separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}