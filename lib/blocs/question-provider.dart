import 'package:flutter/material.dart';

import 'question-bloc.dart';

class QuestionProvider extends InheritedWidget {
  final QuestionBloc bloc;
  final Widget child;
  QuestionProvider({this.child, this.bloc}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static QuestionProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(QuestionProvider);
}