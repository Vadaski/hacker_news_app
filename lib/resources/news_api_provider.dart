import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hacker_news_app/models/item_model.dart';
import 'dart:async';
import './news_interface.dart';

const String url = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider implements Source{
  http.Client client = http.Client();

  //获取头条新闻id
  Future<List<int>> fetchTopIds() async{
    final response = await client.get("$url/topstories.json");
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  //根据id获取头条新闻内容
  Future<ItemModel> fetchItem(int id)async{
    final response = await client.get("$url/item/$id.json");
    final jsonData = json.decode(response.body);
    return ItemModel.fromJson(jsonData);
  }
}