import 'package:flutter/material.dart';
import 'package:flutter_zhihu/resources/local_data_provider.dart';
import 'package:flutter_zhihu/screens/more/question_list_page.dart';


class MorePage extends StatefulWidget{
  @override
  _MorePageState createState() {
    return _MorePageState();
  }
}

class _MorePageState extends State<MorePage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(LocalDataProvider.getInstance().getUserId());
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0xFFF6F6F6),
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    color: Color(0xff488aff),
                    height: 123,
                  ),
                  Container(
                    color: Colors.white,
                    height: 74,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)),
                      )
                    ),
                    child: Column(
                      children: <Widget>[
                        _Item(
                          icon: Icons.question_answer,
                          text: '我的提问',
                          needBorder: true,
                          push: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => QuestionListPage(type: 'question',title: '我的提问',)
                              )
                            );
                          },
                        ),
                        _Item(
                          icon: Icons.report_problem,
                          text: '我的回答',
                          needBorder: true,
                          push: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => QuestionListPage(type: 'answer',title: '我的回答',)
                              )
                            );
                          },
                        ),
                        _Item(
                          icon: Icons.not_interested,
                          text: '我的关注',
                          needBorder: false,
                          push: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => QuestionListPage(type: 'favourite',title: '我的关注',)
                              )
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)),
                      )
                    ),
                    child: Column(
                      children: <Widget>[
          
                        _Item(
                          icon: Icons.content_copy,
                          text: '关于我们',
                          needBorder: true,
                        ),
                        _Item(
                          icon: Icons.settings,
                          text: '设置',
                          needBorder: false,
                        )
                      ],
                    ),
                  ),
                ]),)
            ),
            
            Positioned(
              top: 62.0, left: 15, right: 15, 
              child: Container(
                height: 112,
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2.0, 2.0),
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 4.0,
                          spreadRadius: 0.0)
                    ]),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.white,
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: LocalDataProvider.getInstance()
                                                .getUserHeadface() !=
                                            '' && null != LocalDataProvider.getInstance()
                                        .getUserHeadface()
                                        ? NetworkImage(LocalDataProvider.getInstance()
                                            .getUserHeadface())
                                        : AssetImage('assets/headface.jpg'),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ),
                            )),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              // return AccountInformationPage();
                            },
                          ));
                        },
                      ),
                    ),
                    
                    Container(
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              LocalDataProvider.getInstance().getUserNickName() ?? '匿名',
                              overflow: TextOverflow.ellipsis,
                              //文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
                              style: TextStyle(
                                fontSize: 20.0, //字体大小
                              ),
                            ),
                          ),
                          Text(
                            '点击编辑个人信息',
                            textAlign: TextAlign.left
                          )
                        ],
                      ),
                    ),
                      
                  ],
                ),
              )
            ),
          ]
        ) 
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool needBorder;
  Function push;

  _Item(
      {Key key,
      @required this.icon,
      @required this.text,
      @required this.needBorder,
      this.push})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (push != null) this.push();
      },
      child: Container(
        height: 60,
        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
        decoration: needBorder
            ? BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xFFEEEEEE))))
            : BoxDecoration(color: Colors.white),
        child: Row(
          children: <Widget>[
            Icon(this.icon,color: Colors.lightBlueAccent,),
            Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(text,
                  style: TextStyle(
                    fontSize: 18.0, //字体大小
                    color: const Color(0xFF4A4A4A), //文字颜色
                  )),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right,color: Color(0xFFEEEEEE),)
          ],
        ),
      ),
    );
  }
}
