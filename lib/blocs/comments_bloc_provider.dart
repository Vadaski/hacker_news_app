import 'package:flutter/material.dart';
import './comments_bloc.dart';
export './comments_bloc.dart';

class CommentsBlocProvider extends InheritedWidget {
  final CommentsBloc _bloc;
  CommentsBlocProvider({Key key, Widget child})
      : _bloc = CommentsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CommentsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(CommentsBlocProvider)
              as CommentsBlocProvider)
          ._bloc;
}
