// features/movie_details/data/models/torrent_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'torrent_model.g.dart'; // سيتم توليد هذا الملف تلقائياً

/// نموذج بيانات التورنت لخيارات التحميل
@JsonSerializable()
class TorrentModel {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final int seeds;
  final int peers;
  final String size;
  final int sizeBytes;
  final String dateUploaded;
  final int dateUploadedUnix;

  TorrentModel({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory TorrentModel.fromJson(Map<String, dynamic> json) =>
      _$TorrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TorrentModelToJson(this);
}
