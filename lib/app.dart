import 'package:flutter/material.dart';
import 'screens/news_list_screen.dart';
import 'blocs/news_bloc_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsBlocProvider(
      child: MaterialApp(
        title: "HACKER NEWS",
        home: NewsListScreen(),
      ),
    );
  }
}
