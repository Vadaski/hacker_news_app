import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:hacker_news_app/resources/news_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news_app/models/item_model.dart';

void main(){
  group('http test', (){

    test('fetch top id', () async{
      final apiProvider = NewsApiProvider();
      apiProvider.client = MockClient((request) async{
        return Response(json.encode([1,2,3,4]), 200);
      });
      expect(await apiProvider.fetchTopIds(), [1,2,3,4]);
    });

    test('fetch item', () async{
      final apiProvider = NewsApiProvider();
      apiProvider.client = MockClient((request) async{
        final jsonMap = ItemModel(id: 10392);
        return Response(json.encode(jsonMap),200);
      });
      final item = await apiProvider.fetchItem(10392);
      expect(item.id, 10392);
    });
  });
}