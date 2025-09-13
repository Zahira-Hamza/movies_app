// features/movie_details/data/models/movies/movie_suggestions_response.dart
import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'movie_suggestions_response.g.dart';

@JsonSerializable()
class MovieSuggestionsResponse {
  final String status;
  final String statusMessage;
  final MovieSuggestionsData data;

  MovieSuggestionsResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MovieSuggestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieSuggestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSuggestionsResponseToJson(this);
}

@JsonSerializable()
class MovieSuggestionsData {
  final List<MovieModel> movies;

  MovieSuggestionsData({required this.movies});

  factory MovieSuggestionsData.fromJson(Map<String, dynamic> json) =>
      _$MovieSuggestionsDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSuggestionsDataToJson(this);
}
