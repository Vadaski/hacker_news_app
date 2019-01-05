import 'package:flutter/material.dart';
import '../blocs/news_bloc_provider.dart';
import '../widgets/item_tile.dart';

//class NewsListScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final bloc = NewsBlocProvider.of(context);
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Top News',
//            style: Theme.of(context)
//                .primaryTextTheme
//                .display4
//                .copyWith(fontSize: 24)),
//        centerTitle: true,
//      ),
//      body: refreshWidget(_buildList(bloc), bloc),
//    );
//  }
//
//  Widget _buildList(NewsBloc bloc) {
//    return StreamBuilder(
//      stream: bloc.topIds,
//      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                CircularProgressIndicator(
//                  backgroundColor: Colors.pinkAccent,
//                  strokeWidth: 2,
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(16.0),
//                  child: Text(
//                    'Waiting for data...',
//                    style: Theme.of(context)
//                        .primaryTextTheme
//                        .display4
//                        .copyWith(fontSize: 32),
//                  ),
//                ),
//              ],
//            ),
//          );
//        }
//
//        return ListView.builder(
//            itemCount: snapshot.data.length,
//            itemBuilder: (context, index) {
//              return ItemTile(snapshot.data[index]);
//            });
//      },
//    );
//  }
//
//  Widget refreshWidget(Widget child, NewsBloc bloc) {
//    return RefreshIndicator(
//        child: child,
//        onRefresh: () async {
//          await bloc.clearCache();
//          await bloc.fetchTopIds();
//        });
//  }
//}

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>{


  @override
  Widget build(BuildContext context) {
    final bloc = NewsBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News',
            style: Theme.of(context)
                .primaryTextTheme
                .display4
                .copyWith(fontSize: 24)),
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
                  strokeWidth: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Waiting for data...',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display4
                        .copyWith(fontSize: 32),
                  ),
                ),
              ],
            ),
          );
        }
        return Align(
          alignment: Alignment.bottomCenter,
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ItemTile(snapshot.data[index]);
              }),
        );
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
