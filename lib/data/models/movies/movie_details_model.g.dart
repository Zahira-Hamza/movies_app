// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsResponse _$MovieDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MovieDetailsResponse(
      status: json['status'] as String,
      statusMessage: json['statusMessage'] as String,
      data: MovieDetailsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailsResponseToJson(
        MovieDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusMessage': instance.statusMessage,
      'data': instance.data,
    };

MovieDetailsData _$MovieDetailsDataFromJson(Map<String, dynamic> json) =>
    MovieDetailsData(
      movie: MovieModel.fromJson(json['movie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailsDataToJson(MovieDetailsData instance) =>
    <String, dynamic>{
      'movie': instance.movie,
    };
