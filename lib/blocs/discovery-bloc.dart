import 'dart:async';
import 'dart:convert';

import 'package:flutter_zhihu/resources/network-provider.dart';


class DiscoveryBloc {

  final _apiClient = NetworkProvider();

  List dataList = [];

  StreamSubscription<String> _discoverySubscription;

  final StreamController<String> _discoveryController = StreamController<String>.broadcast();

  Stream<String> get homeStream => _discoveryController.stream;

  getQuestions(index,number) {   // 获取首页列表
    var params = {
      'index':index,
      'number':number
    };
    _discoverySubscription?.cancel();
    _discoverySubscription = _apiClient.getQuestions(params)
        .asStream()
        .listen((String response) {

        if (response != null && response != '') {
          print(json.decode(response));
          if (index == 1){
            dataList = json.decode(response);
          } else {
            dataList.addAll(json.decode(response));
          }
        }

      _discoveryController.add(response);
    });
  }

  void dispose() {
    _discoverySubscription?.cancel();
    _discoveryController.close();
  }

}