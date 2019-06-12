import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zhihu/resources/local_data_provider.dart';
import 'package:flutter_zhihu/screens/tabs/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  bool _isLogin = LocalDataProvider.getInstance().isLogin();


  Widget _changePage(){
    if(_isLogin != null){
      return Tabs();
    }
  }

  // saveSystemInfo() async {
  //   await LocalDataProvider.getInstance().initData();
  //   LocalDataProvider.getInstance().setAppVersion(packageInfo.version);

  //   if (Platform.isIOS) {
  //     LocalDataProvider.getInstance().setIos();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Zhihu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _changePage(),
    );
  }
}
