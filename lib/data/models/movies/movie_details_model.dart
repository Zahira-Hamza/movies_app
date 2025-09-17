import 'movie_model.dart';

class MovieDetailsResponse {
  final String status;
  final String statusMessage;
  final MovieDetailsData? data;
  final Map<String, dynamic>? meta;

  MovieDetailsResponse({
    required this.status,
    required this.statusMessage,
    this.data,
    this.meta,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    print(' Response keys: ${json.keys}');

    // Handle different response structures
    dynamic movieData;

    if (json.containsKey('data')) {
      print(' Found data key');
      movieData = json['data'];

      if (movieData is Map<String, dynamic> && movieData.containsKey('movie')) {
        print(' Data contains movie key');
        movieData = movieData['movie'];
      } else if (movieData is Map<String, dynamic> &&
          (movieData.containsKey('id') || movieData.containsKey('title'))) {
        print('🔍 Data contains movie data directly');
        // movieData remains as is
      }
    } else if (json.containsKey('movie')) {
      print(' Found movie key directly');
      movieData = json['movie'];
    } else if (json.containsKey('id') || json.containsKey('title')) {
      print(' JSON contains movie data at root level');
      movieData = json;
    } else {
      print(' Using entire json as movie data');
      movieData = json;
    }

    print(' Movie data type: ${movieData.runtimeType}');

    return MovieDetailsResponse(
      status: _parseString(json['status']),
      statusMessage:
          _parseString(json['status_message'] ?? json['statusMessage']),
      data: movieData is Map<String, dynamic>
          ? MovieDetailsData.fromJson(movieData)
          : MovieDetailsData.fromJson({}),
      meta: json['@meta'] != null
          ? Map<String, dynamic>.from(json['@meta'])
          : null,
    );
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }
}

class MovieDetailsData {
  final MovieModel? movie;

  MovieDetailsData({this.movie});

  factory MovieDetailsData.fromJson(Map<String, dynamic> json) {
    print(' MovieDetailsData keys: ${json.keys}');

    // If the json already contains movie data at the top level
    if (json.containsKey('id') && json.containsKey('title')) {
      print(' JSON contains movie data directly');
      return MovieDetailsData(
        movie: MovieModel.fromJson(json),
      );
    }

    // If the json has a 'movie' key
    if (json.containsKey('movie')) {
      print(' JSON contains movie key');
      final movieJson = json['movie'];
      if (movieJson is Map<String, dynamic>) {
        return MovieDetailsData(
          movie: MovieModel.fromJson(movieJson),
        );
      }
    }

    print(' Could not find movie data in expected structure');
    return MovieDetailsData(movie: null);
  }
}
