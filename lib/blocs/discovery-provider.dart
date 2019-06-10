import 'package:flutter/material.dart';

import 'discovery-bloc.dart';


class DiscoveryProvider extends InheritedWidget {
  final DiscoveryBloc bloc;
  final Widget child;
  DiscoveryProvider({this.child, this.bloc}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DiscoveryProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(DiscoveryProvider);
}