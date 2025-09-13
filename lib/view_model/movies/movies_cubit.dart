import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/data_sources/remote_data_sources/movies_remote_data_source.dart';
import 'package:movies_app/data/models/movies/movies_model.dart';
import 'movies_states.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRemoteDataSource dataSource;
  List<MoviesModel> _allMovies = [];
  final Map<String, List<MoviesModel>> _moviesByGenre = {};

  MoviesCubit(this.dataSource) : super(MoviesInitial());

  Future<void> fetchMovies() async {
    emit(MoviesLoading());
    try {
      _allMovies = await dataSource.fetchMovies();
      emit(MoviesLoaded(
        movies: _allMovies,
        moviesByGenre: _moviesByGenre.values.expand((x) => x).toList(),
      ));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> fetchMoviesByGenre(String genre) async {
    // If we already have movies for this genre, use them
    if (_moviesByGenre.containsKey(genre)) {
      emit(MoviesLoaded(
        movies: _allMovies,
        moviesByGenre: _moviesByGenre[genre]!,
      ));
      return;
    }

    emit(MoviesLoading());
    try {
      final moviesByGenre = await dataSource.fetchMovies(genre: genre);
      _moviesByGenre[genre] = moviesByGenre;
      
      emit(MoviesLoaded(
        movies: _allMovies,
        moviesByGenre: moviesByGenre,
      ));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}


