import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zhihu/blocs/home-bloc.dart';
import 'home_iitem.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  HomeBloc _bloc = HomeBloc();
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
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
                dataList = json.decode(snapshot.data);
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