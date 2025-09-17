abstract class FavMoviesStates {}

class FavMoviesInitial extends FavMoviesStates {}

class GetFavMoviesLoading extends FavMoviesStates {}

class GetFavMoviesSuccess extends FavMoviesStates {}

class FavMoviesError extends FavMoviesStates {
  final String message;
  FavMoviesError(this.message);
}

class IsFavMovieSuccess extends FavMoviesStates {
  final bool isFav;
  IsFavMovieSuccess(this.isFav);
}
