import 'package:flutter/material.dart';
import 'news_list_screen.dart';
import '../blocs/news_bloc_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              NewsBlocProvider.of(context).fetchTopIds();
          return NewsListScreen();
        }), (route) => route == null);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: Center(
          child: Text(
            'Hacker News',
            style: Theme.of(context)
                .primaryTextTheme
                .display4
                .copyWith(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
