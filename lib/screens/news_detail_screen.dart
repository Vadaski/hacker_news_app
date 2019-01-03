import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../blocs/comments_bloc_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetailScreen extends StatelessWidget {
  final int id;

  NewsDetailScreen({this.id});
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    CommentsBloc bloc = CommentsBlocProvider.of(context);
    return Scaffold(body: _buildBody(bloc, context));
  }

  Widget _buildBody(CommentsBloc bloc, BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: bloc.itemWithComments,
          builder:
              (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
            if (!snapshot.hasData) return Center(child: Text('loading...'));
            return FutureBuilder(
                future: snapshot.data[id],
                builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                  if (!itemSnapshot.hasData) return Text('wait for data');
                  return _buildListBody(
                    context,
                    itemSnapshot.data,
                    snapshot.data,
                  );
                });
          }),
    );
  }

  Widget _buildListBody(BuildContext context, ItemModel item,
      Map<int, Future<ItemModel>> itemMap) {
    List children = List<Widget>();
    children.add(_buildTitle(context, item));
    final commentsList = item.kids.map((kid) => Comment(id, itemMap)).toList();
    children.addAll(commentsList);
    return ListView(children: children);
  }

  Widget _buildTitle(BuildContext context, ItemModel item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        item.title,
        style: Theme.of(context)
            .primaryTextTheme
            .display4
            .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
