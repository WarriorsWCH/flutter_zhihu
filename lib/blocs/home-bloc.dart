import 'dart:async';

import 'package:flutter_zhihu/resources/network-provider.dart';


class HomeBloc {

  final _apiClient = NetworkProvider();

  StreamSubscription<String> _homeSubscription;

  final StreamController<String> _homeController = StreamController<String>.broadcast();

  Stream<String> get homeStream => _homeController.stream;

  getFeeds() {   // 获取首页列表
    _homeSubscription?.cancel();
    _homeSubscription = _apiClient.getFeeds()
        .asStream()
        .listen((String response) {
      _homeController.add(response);
    });
  }

  void dispose() {
    _homeSubscription?.cancel();
    _homeController.close();
  }

}