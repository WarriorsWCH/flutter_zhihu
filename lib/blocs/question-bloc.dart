import 'dart:async';
import 'dart:convert';

import 'package:flutter_zhihu/resources/network-provider.dart';


class QuestionBloc {

  final _apiClient = NetworkProvider();
  List dataList = [];
  StreamSubscription<String> _questionSubscription;

  final StreamController<String> _questionController = StreamController<String>.broadcast();

  Stream<String> get questionStream => _questionController.stream;

  getUserQuestionList(userid,type) {  
    var params = {
      'userid':userid,
      'type':type
    };
    _questionSubscription?.cancel();
    _questionSubscription = _apiClient.getUserQuestionList(params)
        .asStream()
        .listen((String response) {

      if (response != null && response != '') {
        
        dataList.addAll(json.decode(response));
      }
      _questionController.add(response);
    });
  }

  void dispose() {
    _questionSubscription?.cancel();
    _questionController.close();
  }

}