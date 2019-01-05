import 'dart:async';
import 'package:flutter/material.dart';
import 'package:async/async.dart' as async;
import 'package:url_launcher/url_launcher.dart';
import '../blocs/news_bloc_provider.dart';
import '../blocs/comments_bloc_provider.dart';
import '../models/item_model.dart';
import '../screens/news_detail_screen.dart';

class ItemTile extends StatefulWidget {
  final int id;
  ItemTile(this.id);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile>
    with SingleTickerProviderStateMixin {
  double _animationOpacity = 0;
  final _asyncMemoize = async.AsyncMemoizer<ItemModel>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100))
        .then((_) => _animationOpacity = 1);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = NewsBlocProvider.of(context);
    bloc.fetchItems(widget.id);
    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _defaultNewsContainer();
          default:
        }

        if (!snapshot.hasData) {
          return _defaultNewsContainer();
        }
        return FutureBuilder(
          future: _futureItem(snapshot),
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) return _defaultNewsContainer();
            ;
            final secondChild = _buildItemTile(context, itemSnapshot);
            return AnimatedOpacity(
              opacity: _animationOpacity,
              duration: Duration(milliseconds: 500),
              child: secondChild,
            );
          },
        );
      },
    );
  }

  Widget _buildItemTile(
      BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            '${itemSnapshot.data.title}',
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('${itemSnapshot.data.score} scores'),
          ),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.chat),
              Text(
                '${itemSnapshot.data.descendants}',
              )
            ],
          ),
          onTap: () {
            CommentsBlocProvider.of(context).fetchItemWithComments(widget.id);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewsDetailScreen(
                      id: widget.id,
                    )));
          },
          onLongPress: () {
            _launchInBrowser(itemSnapshot.data.url);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Divider(),
        ),
      ],
    );
  }

  Widget _defaultNewsContainer() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Container(
            height: 20,
            color: Colors.blueGrey.withOpacity(0.2),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 40,
                height: 20,
                color: Colors.blueGrey.withOpacity(0.2),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Divider(),
        ),
      ],
    );
  }

  //缓存futureItem
  Future<ItemModel> _futureItem(
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) =>
      _asyncMemoize.runOnce(() async {
        Future<ItemModel> futureModel = snapshot.data[widget.id];
        return futureModel;
      });

  //打开webview
  Future<Null> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  //打开浏览器
  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
