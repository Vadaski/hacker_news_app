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
          return Center(
            child: Text('...'),
          );
        }
        final item = snapshot.data;
        final time = DateTime.fromMicrosecondsSinceEpoch(item.time);
        final children = <Widget>[
          ListTile(
              title: item.text == null ? Container() : Text(item.text),
              subtitle: item.by == null
                  ? Text("the comments already deleted")
                  : Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Align(alignment: Alignment.bottomRight,child: Text("by: ${item.by}"),),
                    )),
          Divider(),
        ];
        item.kids.forEach((kidId) => children.add(Comment(kidId, itemMap)));
        return Container(
            color: Colors.blue.withOpacity(0.1),
            padding: EdgeInsets.only(left: 8),
            child: Column(children: children));
      },
    );
  }
}
