/// File: featured.videos.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 1:36:11 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 3:18:30 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/features/home/domain/entities/featured.videos.dart';

part 'featured.videos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FeaturedVideo extends BaseFeaturedVideo {
  final String id;
  final String title;
  final String url;
  final String img;
  final String createdAt;

  FeaturedVideo({
    required this.id,
    required this.title,
    required this.url,
    required this.img,
    required this.createdAt,
  });

  factory FeaturedVideo.fromJson(json) => _$FeaturedVideoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FeaturedVideoToJson(this);
}
