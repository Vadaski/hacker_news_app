import 'package:json_annotation/json_annotation.dart';
import 'dart:convert' show json;

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel{

  ItemModel({this.id, this.deleted, this.type, this.by, this.time, this.text,
    this.dead, this.parent, this.kids, this.url, this.score, this.title,
    this.descendants});

  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel{id: $id, deleted: $deleted, type: $type, by: $by, time: $time, text: $text, dead: $dead, parent: $parent, kids: $kids, url: $url, score: $score, title: $title, descendants: $descendants}';
  }

  ItemModel.fromDb(Map<String ,dynamic> db):
    id = db['id'],
    deleted = db['delete']==1,
    type = db['type'],
    by = db['by'],
    time = db['time'],
    text = db['text'],
    dead = db['dead']==1,
    parent = db['parent'],
    kids = json.decode(db['kids']),
    url = db['url'],
    score = db['score'],
    title = db['title'],
    descendants = db['descendants'];

  Map<String, dynamic> toDbMap() => <String ,dynamic>{
    "id" : id,
    "deleted" : deleted ? 1 : 0,
    "type" : type,
    "by" : by,
    "time" : time,
    "text" : text,
    "dead" : dead ? 1 : 0,
    "parent" : parent,
    "kids" : json.encode(kids),
    "url" : url,
    "score" : score,
    "title" : title,
    "descendants" : descendants
  };
}