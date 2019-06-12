
import 'package:flutter/material.dart';
import 'package:flutter_zhihu/blocs/discovery-bloc.dart';
import 'package:flutter_zhihu/screens/home/home_iitem.dart';

class PutQuestions extends StatefulWidget{
  @override
  _PutQuestionsState createState() {
    return _PutQuestionsState();
  }
}

class _PutQuestionsState extends State<PutQuestions> {


  @override
  void initState() {
    super.initState();
    // _bloc.getQuestions(1, 10);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies(); 
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
        title: Text('提问',style: TextStyle(
          color: Color.fromRGBO(74, 74, 74, 1.0),
          fontSize: 18.0,
          fontFamily: "PingFangSC-Regular")
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF4A4A4A)),
          alignment: Alignment.centerLeft,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: Container()
      ),
    );
  }
}