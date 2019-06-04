import 'package:flutter/material.dart';

import 'home-bloc.dart';

class HomeProvider extends InheritedWidget {
  final HomeBloc bloc;
  final Widget child;
  HomeProvider({this.child, this.bloc}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static HomeProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(HomeProvider);
}