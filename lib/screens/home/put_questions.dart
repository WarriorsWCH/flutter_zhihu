import 'package:flutter/material.dart';
import 'package:flutter_zhihu/resources/local_data_provider.dart';
import 'package:flutter_zhihu/resources/network-provider.dart';
import 'package:flutter_zhihu/screens/discovery/discovery_page.dart';
import 'package:flutter_zhihu/screens/login/login_btn.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PutQuestions extends StatefulWidget {
  @override
  _PutQuestionsState createState() {
    return _PutQuestionsState();
  }
}

class _PutQuestionsState extends State<PutQuestions> {

  int textLength = 0;
  final _apiClient = NetworkProvider();
  String _title;
  String _content;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        toolbarOpacity: 1.0,
        elevation: 0.5, //整个导航栏的不透明度
        brightness: Brightness.light, //状态栏上的字体为黑色
        title: Text('提问',
            style: TextStyle(
                color: Color.fromRGBO(74, 74, 74, 1.0),
                fontSize: 18.0,
                fontFamily: "PingFangSC-Regular")),
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
          child: Theme(
            data: ThemeData(
                primaryColor: Color(0xFFF6F6F6),
                hintColor: Color(0xFFF6F6F6)),
            child: Column(
              children: <Widget>[
                Container(height: 20,),
                TextField(
                  style: TextStyle(),
                  textInputAction: TextInputAction.done,
                  maxLength: 100,
                  maxLines: 1,
                  maxLengthEnforced: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      fillColor: Color(0xFFF6F6F6),
                      filled: true,
                      hintText: '请输入问题标题',
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 22),
                      hintStyle: TextStyle(color: Color(0xFF999999)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      )),
                  onChanged: (text) {
                    setState(() {
                      textLength = text.length;
                      _title = text;
                    });
                  }),
                Stack(
                  children: <Widget>[
                    TextField(
                      style: TextStyle(),
                      textInputAction: TextInputAction.done,
                      maxLength: 500,
                      maxLines: 5,
                      maxLengthEnforced: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFF6F6F6),
                          filled: true,
                          hintText: '请您在此详细描述问题',
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 22),
                          hintStyle: TextStyle(color: Color(0xFF999999)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          )),
                      onChanged: (text) {
                        setState(() {
                          textLength = text.length;
                          _content = text;
                        });
                      }),
                    Positioned(
                      bottom: 28,
                      right: 12,
                      child: Text('${textLength}/500',
                          style: TextStyle(
                            color: Color(0xFF999999),
                          )),
                    )
                  ],
                ),
                LoginBtn(press: (){
                  showLoginDialog();
                  _apiClient.saveQuestion({
                    'userid': LocalDataProvider.getInstance().getUserId(),
                    'title':_title,
                    'content':_content
                  }).then((res){
                    pr.hide();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context)=>DiscoveryPage()
                    // ));
                    Navigator.of(context).pop();
                  });
                },bgColor: Color(0xff488aff),fontColor: Color(0xffffffff),name: '提交',),
              ],
            ),
          )
    ));
  }

  showLoginDialog() {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('发表中...');
    pr.show();
  }
}
