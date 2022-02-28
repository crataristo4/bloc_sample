// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured.videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturedVideo _$FeaturedVideoFromJson(Map<String, dynamic> json) {
  return FeaturedVideo(
    id: json['id'] as String,
    title: json['title'] as String,
    url: json['url'] as String,
    img: json['img'] as String,
    createdAt: json['created_at'] as String,
  );
}

Map<String, dynamic> _$FeaturedVideoToJson(FeaturedVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'img': instance.img,
      'created_at': instance.createdAt,
    };
