import 'package:flutter/material.dart';
import 'screens/news_list_screen.dart';
import 'blocs/news_bloc_provider.dart';
import 'blocs/comments_bloc_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsBlocProvider(
      child: NewsBlocProvider(
        child: MaterialApp(
          theme: ThemeData.dark(),
          title: "HACKER NEWS",
          home: NewsListScreen(),
        ),
      ),
    );
  }
}
