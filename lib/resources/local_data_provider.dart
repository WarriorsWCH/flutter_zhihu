import 'package:flutter/material.dart';

class LocalDataProvider{

  static LocalDataProvider _instance;


  static LocalDataProvider getInstance(){
    //单例
    if (_instance == null) {
      _instance = LocalDataProvider();
    }
    return _instance;
  }

  bool isLogin(){
    return true;
  }
}