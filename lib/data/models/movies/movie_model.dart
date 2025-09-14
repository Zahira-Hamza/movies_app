// // core/models/movie_model.dart
// import 'package:json_annotation/json_annotation.dart';
//
// part 'movie_model.g.dart'; // سيتم توليد هذا الملف تلقائياً
//
// /// نموذج بيانات الفيلم الأساسي
// @JsonSerializable()
// class MovieModel {
//   final int id;
//   final String title;
//   final String titleLong;
//   final double rating;
//   final int runtime;
//   final List<String> genres;
//   final String summary;
//   final String descriptionFull;
//   final String language;
//   final String backgroundImage;
//   final String mediumCoverImage;
//   final String largeCoverImage;
//   final int year;
//
//   MovieModel({
//     required this.id,
//     required this.title,
//     required this.titleLong,
//     required this.rating,
//     required this.runtime,
//     required this.genres,
//     required this.summary,
//     required this.descriptionFull,
//     required this.language,
//     required this.backgroundImage,
//     required this.mediumCoverImage,
//     required this.largeCoverImage,
//     required this.year,
//   });
//
//   /// تحويل JSON إلى MovieModel
//   factory MovieModel.fromJson(Map<String, dynamic> json) =>
//       _$MovieModelFromJson(json);
//
//   /// تحويل MovieModel إلى JSON
//   Map<String, dynamic> toJson() => _$MovieModelToJson(this);
// }
class MovieModel {
  final int id;
  final String title;
  final String? titleLong;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String? summary;
  final String? descriptionFull;
  final String? language;
  final String? backgroundImage;
  final String? mediumCoverImage;
  final String? largeCoverImage;
  final int year;

  MovieModel({
    required this.id,
    required this.title,
    this.titleLong,
    required this.rating,
    required this.runtime,
    required this.genres,
    this.summary,
    this.descriptionFull,
    this.language,
    this.backgroundImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    required this.year,
  });

  // Manual parsing بدل json_annotation
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: _parseInt(json['id']),
      title: _parseString(json['title']),
      titleLong: _parseStringNullable(json['titleLong']),
      rating: _parseDouble(json['rating']),
      runtime: _parseInt(json['runtime']),
      genres: _parseStringList(json['genres']),
      summary: _parseStringNullable(json['summary']),
      descriptionFull: _parseStringNullable(json['descriptionFull']),
      language: _parseStringNullable(json['language']),
      backgroundImage: _parseStringNullable(json['backgroundImage']),
      mediumCoverImage: _parseStringNullable(json['mediumCoverImage']),
      largeCoverImage: _parseStringNullable(json['largeCoverImage']),
      year: _parseInt(json['year']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'titleLong': titleLong,
      'rating': rating,
      'runtime': runtime,
      'genres': genres,
      'summary': summary,
      'descriptionFull': descriptionFull,
      'language': language,
      'backgroundImage': backgroundImage,
      'mediumCoverImage': mediumCoverImage,
      'largeCoverImage': largeCoverImage,
      'year': year,
    };
  }

  // Helper functions
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static String? _parseStringNullable(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    final str = value.toString();
    return str.isEmpty ? null : str;
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .map((e) => _parseString(e))
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [];
  }
}
