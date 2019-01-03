import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int id;
  final Map<int, Future<ItemModel>> itemMap;
  Comment(this.id, this.itemMap);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[id],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text('...'),);
        }
        final item = snapshot.data;
        final children = <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: ListTile(
              title: Text(item.text),
              subtitle: Text(item.by),
            ),
          ),
          Divider()
        ];
        item.kids
            .forEach((kidId) => children.add(Comment(kidId, itemMap)));
        return Column(
          children: children,
        );
      },
    );
  }
}
