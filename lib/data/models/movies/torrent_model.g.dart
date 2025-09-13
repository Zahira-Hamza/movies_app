// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'torrent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TorrentModel _$TorrentModelFromJson(Map<String, dynamic> json) => TorrentModel(
      url: json['url'] as String,
      hash: json['hash'] as String,
      quality: json['quality'] as String,
      type: json['type'] as String,
      seeds: (json['seeds'] as num).toInt(),
      peers: (json['peers'] as num).toInt(),
      size: json['size'] as String,
      sizeBytes: (json['sizeBytes'] as num).toInt(),
      dateUploaded: json['dateUploaded'] as String,
      dateUploadedUnix: (json['dateUploadedUnix'] as num).toInt(),
    );

Map<String, dynamic> _$TorrentModelToJson(TorrentModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'hash': instance.hash,
      'quality': instance.quality,
      'type': instance.type,
      'seeds': instance.seeds,
      'peers': instance.peers,
      'size': instance.size,
      'sizeBytes': instance.sizeBytes,
      'dateUploaded': instance.dateUploaded,
      'dateUploadedUnix': instance.dateUploadedUnix,
    };
