import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../utils/text_helper.dart';

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
        final text = textConverter(item.text);
        final time = DateTime.fromMillisecondsSinceEpoch(item.time*1000);
        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
              title: item.text == null ? Container() : Text(text),
              subtitle: item.by == null
                  ? Text("the comments already deleted")
                  : Padding(
                      padding: EdgeInsets.only(top: 8,right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${item.by}'),
                          Text(time.toIso8601String().substring(5,10)),
                        ],
                      )
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
