// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      titleLong: json['titleLong'] as String,
      rating: (json['rating'] as num).toDouble(),
      runtime: (json['runtime'] as num).toInt(),
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      summary: json['summary'] as String,
      descriptionFull: json['descriptionFull'] as String,
      language: json['language'] as String,
      backgroundImage: json['backgroundImage'] as String,
      mediumCoverImage: json['mediumCoverImage'] as String,
      largeCoverImage: json['largeCoverImage'] as String,
      year: (json['year'] as num).toInt(),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleLong': instance.titleLong,
      'rating': instance.rating,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'summary': instance.summary,
      'descriptionFull': instance.descriptionFull,
      'language': instance.language,
      'backgroundImage': instance.backgroundImage,
      'mediumCoverImage': instance.mediumCoverImage,
      'largeCoverImage': instance.largeCoverImage,
      'year': instance.year,
    };
