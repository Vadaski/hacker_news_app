import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hacker_news_app/blocs/news_bloc_provider.dart';
import '../models/item_model.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = NewsBlocProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
        centerTitle: true,
      ),
      body: refreshWidget(_buildList(bloc), bloc),
    );
  }

  Widget _buildList(NewsBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.pinkAccent,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Waiting for data...',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ItemTile(snapshot.data[index]);
            });
      },
    );
  }

  Widget refreshWidget(Widget child, NewsBloc bloc) {
    return RefreshIndicator(
        child: child,
        onRefresh: () async {
          await bloc.clearCache();
          await bloc.fetchTopIds();
        });
  }
}

class ItemTile extends StatelessWidget {
  final int id;
  ItemTile(this.id);

  @override
  Widget build(BuildContext context) {
    final bloc = NewsBlocProvider.of(context);
    bloc.fetchItems(id);
    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return _defaultNewsContainer();
        }
        return FutureBuilder(
          future: snapshot.data[id],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return _defaultNewsContainer();
            }
            return ListTile(
              title: Text('${itemSnapshot.data.title}'),
              subtitle: Text('${itemSnapshot.data.score} scores'),
              trailing: Column(
                children: <Widget>[
                  Icon(Icons.chat),
                  Text('${itemSnapshot.data.descendants}')
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _defaultNewsContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Container(
          height: 24,
          color: Colors.grey.shade200,
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 40,
            height: 24,
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
