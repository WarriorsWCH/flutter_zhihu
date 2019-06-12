import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zhihu/blocs/home-bloc.dart';
import 'package:flutter_zhihu/screens/home/put_questions.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        toolbarOpacity: 1.0,
        elevation: 0.5,//整个导航栏的不透明度
        brightness: Brightness.light,//状态栏上的字体为黑色
        title: Text('首页',style: TextStyle(
          color: Color.fromRGBO(74, 74, 74, 1.0),
          fontSize: 18.0,
          fontFamily: "PingFangSC-Regular")
        ),
        actions: <Widget>[
          IconButton(
            color: Color(0xff488aff),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            disabledColor: Colors.transparent,
            icon: Icon(Icons.question_answer),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PutQuestions()
                )
              );
            },
          )
        ],
      ),
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