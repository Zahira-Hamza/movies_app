///تحويل JSON → Dart Objects.
//
// تسهيل التعامل مع استجابات API.
//
// منع الأخطاء اللي ممكن تحصل لو فضلتِ تستخدمي Maps عادية.
import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'movie_details_model.g.dart'; // سيتم توليد هذا الملف تلقائياً

/// استجابة تفاصيل الفيلم من API
@JsonSerializable()
class MovieDetailsResponse {
  final String status;
  final String statusMessage;
  final MovieDetailsData data;

  MovieDetailsResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsResponseToJson(this);
}

/// بيانات تفاصيل الفيلم
@JsonSerializable()
class MovieDetailsData {
  final MovieModel movie;

  MovieDetailsData({required this.movie});

  factory MovieDetailsData.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsDataToJson(this);
}
