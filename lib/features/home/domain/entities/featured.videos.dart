/// File: featured.videos.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 1:36:04 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 3:17:55 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

/// base entity for featured videos
abstract class BaseFeaturedVideo {
  late String id;
  late String title;
  late String url;
  late String img;
  late String createdAt;

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}
