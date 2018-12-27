import '../models/item_model.dart';

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache{
  clear();
  Future<int> addItem(ItemModel item);
}