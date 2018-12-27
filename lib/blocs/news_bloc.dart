import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item_model.dart';

class NewsBloc {
  final _topIds = PublishSubject<List<int>>();
  final _itemsFetcher =  PublishSubject<int>();
  final _itemOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _repository = NewsRepository();

  NewsBloc() {
    _itemsFetcher.transform(_itemTransformer()).pipe(_itemOutput);
  }

  Observable<Map<int, Future<ItemModel>>> get items => _itemOutput.stream;
  Observable<List<int>> get topIds => _topIds.stream;
  Function(int) get fetchItems => _itemsFetcher.sink.add;

  fetchTopIds() async {
    final topIds = await _repository.fetchTopIds();
    _topIds.sink.add(topIds);
  }

  clearCache ()=> _repository.clearCache();

  _itemTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, _) {
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, Map<int, Future<ItemModel>>());
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemOutput.close();
  }
}
