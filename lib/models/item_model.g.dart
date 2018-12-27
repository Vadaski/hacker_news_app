// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
      id: json['id'] as int,
      deleted: json['deleted'] ?? false,
      type: json['type'] as String,
      by: json['by'] as String,
      time: json['time'] as int,
      text: json['text'] ?? '',
      dead: json['dead'] ?? false,
      parent: json['parent'] as int,
      kids: json['kids'] ?? [],
      url: json['url'] as String,
      score: json['score'] as int,
      title: json['title'] ?? '',
      descendants: json['descendants'] ?? 0);
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'deleted': instance.deleted,
      'type': instance.type,
      'by': instance.by,
      'time': instance.time,
      'text': instance.text,
      'dead': instance.dead,
      'parent': instance.parent,
      'kids': instance.kids,
      'url': instance.url,
      'score': instance.score,
      'title': instance.title,
      'descendants': instance.descendants
    };
