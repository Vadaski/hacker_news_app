import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  CommentsBloc() {
    _commentsFetcher.transform(_commentsTransFormer()).pipe(_commentsOutPut);
  }

  final _repository = NewsRepository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutPut = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //stream
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutPut.stream;

  //sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  _commentsTransFormer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index) {
      cache[id] = _repository.fetchItem(id)
        ..then((ItemModel item) {
          item.kids.forEach((kid) => fetchItemWithComments(kid));
        });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutPut.close();
  }
}
