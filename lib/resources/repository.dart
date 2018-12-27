import './news_api_provider.dart';
import './news_db_provider.dart';
import '../models/item_model.dart';
import './news_interface.dart';

class NewsRepository{
  List<Source> _sourceList = [
    dbProvider,
    NewsApiProvider(),
  ];

  List<Cache> _cacheList = [
    dbProvider
  ];

  //fetchTopIds from network
  Future<List<int>> fetchTopIds() => _sourceList[1].fetchTopIds();

  Future<ItemModel> fetchItem(int id) async{
    ItemModel item;
    var source;
    for(source in _sourceList){
      item = await source.fetchItem(id);
      if(item != null) break;
    }

    for(var cache in _cacheList){
      if(cache != source) cache.addItem(item);
    }
    return item;
  }

  clearCache() async{
    for(var cache in _cacheList){
      await cache.clear();
    }
  }
}

