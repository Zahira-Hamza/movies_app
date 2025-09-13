// features/movie_details/presentation/pages/movie_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/view/screens/movie_details/screenshot_gallery_widget.dart';
import 'package:movies_app/view/screens/movie_details/similar_movies_widget.dart';

import '../../../data/models/movies/movie_model.dart';
import '../../../view_model/movies/movie_details_cubit.dart';
import 'movie_header_widget.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final MovieModel? movie;

  const MovieDetailsPage({
    Key? key,
    required this.movieId,
    this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();

    // إذا لم يتم تمرير بيانات الفيلم كاملة، نطلبها من الـ API
    if (widget.movie == null) {
      context.read<MovieDetailsCubit>().getMovieDetails(widget.movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailsCubit, MovieDetailsStates>(
        listener: (context, state) {
          // يمكن إضافة أي تفاعلات إضافية هنا
        },
        builder: (context, state) {
          // إذا تم تمرير الفيلم مباشرة، نعرضه مباشرة
          if (widget.movie != null) {
            final movie = widget.movie!;
            return _buildMovieContent(movie, const [], null);
          }

          if (state is MovieDetailsLoadingState) {
            return _buildLoadingState();
          } else if (state is MovieDetailsErrorState) {
            return _buildErrorState(state);
          } else if (state is MovieDetailsSuccessState) {
            final movie = state.movie;
            final similarMovies = state.similarMovies;
            return _buildMovieContent(movie, similarMovies, null);
          } else if (state is MovieDetailsPartialSuccessState) {
            return _buildMovieContent(state.movie, [], state.errorMessage);
          } else {
            return _buildInitialState();
          }
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading movie details...'),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Text('Please wait...'),
    );
  }

  Widget _buildErrorState(MovieDetailsErrorState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              state.isNetworkError ? Icons.wifi_off : Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              state.errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            if (state.errorCode != null)
              Text(
                'Error Code: ${state.errorCode}',
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 32),
            if (state.isNetworkError)
              ElevatedButton.icon(
                onPressed: () {
                  context
                      .read<MovieDetailsCubit>()
                      .getMovieDetails(widget.movieId);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Connection'),
              )
            else
              ElevatedButton(
                onPressed: () {
                  context
                      .read<MovieDetailsCubit>()
                      .getMovieDetails(widget.movieId);
                },
                child: const Text('Try Again'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieContent(
      MovieModel movie, List<MovieModel> similarMovies, String? errorMessage) {
    return CustomScrollView(
      slivers: [
        // رأس الفيلم
        SliverToBoxAdapter(
          child: MovieHeaderWidget(movie: movie),
        ),

        // محتوى الصفحة
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // زر المشاهدة
                _buildWatchButton(),
                const SizedBox(height: 20),

                // التقييم
                _buildRatingSection(movie),
                const SizedBox(height: 24),

                // لقطات الشاشة
                _buildScreenshotsSection(movie),
                const SizedBox(height: 24),

                // الأفلام المشابهة (إذا كانت متوفرة)
                if (similarMovies.isNotEmpty) ...[
                  _buildSimilarMoviesSection(similarMovies),
                  const SizedBox(height: 24),
                ],

                // وصف الفيلم
                _buildDescriptionSection(movie),
                const SizedBox(height: 24),

                // التصنيفات
                _buildGenresSection(movie),
                const SizedBox(height: 24),

                // رسالة الخطأ الجزئي (إذا وجدت)
                if (errorMessage != null)
                  _buildPartialErrorBanner(errorMessage),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWatchButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showTorrentOptions(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
        child: const Text(
          'Watch Now',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildRatingSection(MovieModel movie) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 28),
        const SizedBox(width: 8),
        Text(
          '${movie.rating}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        const Text(
          '/10',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const Spacer(),
        Text(
          '${movie.runtime} min',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildScreenshotsSection(MovieModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Screens'
          'Screenshots',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ScreenshotGalleryWidget(movie: movie),
      ],
    );
  }

  Widget _buildSimilarMoviesSection(List<MovieModel> similarMovies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Similar Movies',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SimilarMoviesWidget(movies: similarMovies),
      ],
    );
  }

  Widget _buildDescriptionSection(MovieModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          movie.descriptionFull.isNotEmpty
              ? movie.descriptionFull
              : movie.summary,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildGenresSection(MovieModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Genres',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: movie.genres
              .map((genre) => Chip(
                    label: Text(genre),
                    backgroundColor: Colors.blue[50],
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPartialErrorBanner(String errorMessage) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                'Partial Load',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Movie loaded successfully but similar movies failed: $errorMessage',
            style: TextStyle(color: Colors.orange[800]),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context
                  .read<MovieDetailsCubit>()
                  .retryLoadingSimilarMovies(widget.movieId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry Loading Similar Movies'),
          ),
        ],
      ),
    );
  }

  void _showTorrentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Qualities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
// قائمة جودة التحميل (سيتم ملؤها من API في التطبيق الحقيقي)
              _buildTorrentOption('1080p', '2.1 GB', 'Good quality'),
              _buildTorrentOption('720p', '1.5 GB', 'Balanced quality'),
              _buildTorrentOption('480p', '800 MB', 'Fast download'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTorrentOption(String quality, String size, String description) {
    return ListTile(
      leading: const Icon(Icons.download),
      title: Text(quality),
      subtitle: Text('$size • $description'),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.pop(context);
        _showDownloadConfirmation(quality);
      },
    );
  }

  void _showDownloadConfirmation(String quality) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start Download?'),
        content: Text('Download in $quality quality?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Downloading in $quality quality...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }
}
