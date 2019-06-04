import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zhihu/blocs/home-bloc.dart';
import 'package:flutter_zhihu/utils/screen_util.dart';

import 'home-iitem.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _bloc.getFeeds();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: StreamBuilder(
          stream: _bloc.homeStream,
          builder: (context, snapshot){
            List dataList = [];
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                print(json.decode(snapshot.data));
                dataList = json.decode(snapshot.data);
                print(dataList[0]);
              }
            }
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return HomeItem(dataList[index]);
                },
                itemCount: dataList.length,
            );
          },
        ),
      ),
    );
  }
}