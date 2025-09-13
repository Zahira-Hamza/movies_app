// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_suggestions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSuggestionsResponse _$MovieSuggestionsResponseFromJson(
        Map<String, dynamic> json) =>
    MovieSuggestionsResponse(
      status: json['status'] as String,
      statusMessage: json['statusMessage'] as String,
      data: MovieSuggestionsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieSuggestionsResponseToJson(
        MovieSuggestionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusMessage': instance.statusMessage,
      'data': instance.data,
    };

MovieSuggestionsData _$MovieSuggestionsDataFromJson(
        Map<String, dynamic> json) =>
    MovieSuggestionsData(
      movies: (json['movies'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieSuggestionsDataToJson(
        MovieSuggestionsData instance) =>
    <String, dynamic>{
      'movies': instance.movies,
    };
