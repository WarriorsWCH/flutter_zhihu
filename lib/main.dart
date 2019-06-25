import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zhihu/resources/local_data_provider.dart';
import 'package:flutter_zhihu/screens/login/login_page.dart';
import 'package:flutter_zhihu/screens/tabs/tabs.dart';


saveSystemInfo() async {
  await LocalDataProvider.getInstance().initData();

  if (Platform.isIOS) {
    LocalDataProvider.getInstance().setIos();
  }
}

bool isLogin;

void main() async{
  isLogin = LocalDataProvider.getInstance().isLogin();
  await saveSystemInfo();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {

  bool _isLogin = LocalDataProvider.getInstance().isLogin();


  Widget _changePage() {
    if (isLogin != null) {
      if (isLogin) {
        return Tabs();
      } else {
        return LoginPage();
      }
    } else {
      return LoginPage();
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '知乎',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _changePage(),
    );
  }
}
