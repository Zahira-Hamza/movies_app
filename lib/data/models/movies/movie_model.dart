// core/models/movie_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart'; // سيتم توليد هذا الملف تلقائياً

/// نموذج بيانات الفيلم الأساسي
@JsonSerializable()
class MovieModel {
  final int id;
  final String title;
  final String titleLong;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String language;
  final String backgroundImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final int year;

  MovieModel({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.language,
    required this.backgroundImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.year,
  });

  /// تحويل JSON إلى MovieModel
  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  /// تحويل MovieModel إلى JSON
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
