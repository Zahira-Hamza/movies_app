import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/movies/fav_movies_list_response/movie_basic_info.dart';
import 'package:movies_app/data/repositories/fav_movies_repository.dart';
import 'package:movies_app/view_model/movies/fav_movies_states.dart';

class FavMoviesCubit extends Cubit<FavMoviesStates> {
  FavMoviesCubit() : super(FavMoviesInitial());

  final FavMoviesRepository _favMoviesRepository = FavMoviesRepository();
  List<MovieBasicInfo> favMoviesIds = [];

  Future<void> isFavMovie(String movieId) async {
    final result = await _favMoviesRepository.isFavMovie(movieId);
    result.fold((faliure) => emit(FavMoviesError(faliure.errorMessage)),
        (result) => emit(IsFavMovieSuccess(result)));
  }

  Future<void> getAllFavMovies() async {
    emit(GetFavMoviesLoading());
    final result = await _favMoviesRepository.getAllFavMovies();
    result.fold((faliure) => emit(FavMoviesError(faliure.errorMessage)),
        (result) {
      emit(GetFavMoviesSuccess());
      favMoviesIds = result;
    });
  }
}
