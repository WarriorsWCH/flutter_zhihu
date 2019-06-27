
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zhihu/blocs/question-bloc.dart';
import 'package:flutter_zhihu/resources/local_data_provider.dart';
import 'package:flutter_zhihu/screens/home/home_iitem.dart';
// import 'package:flutter_zhihu/utils/date_util.dart';
import 'package:intl/intl.dart' show DateFormat;

class QuestionListPage extends StatefulWidget{

  final String type;
  final String title;
  QuestionListPage({
    this.type,
    this.title
  });
  @override
  _QuestionListPageState createState() {
    return _QuestionListPageState();
  }
}

class _QuestionListPageState extends State<QuestionListPage> with AutomaticKeepAliveClientMixin{

  QuestionBloc _bloc = QuestionBloc();
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies(); 
    _bloc.getUserQuestionList(LocalDataProvider.getInstance().getUserId(),widget.type);
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
        title: Text(widget.title,style: TextStyle(
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
        child: StreamBuilder(
          stream: _bloc.questionStream,
          builder: (context, snapshot){
          
            return ListView.builder(
              itemCount: _bloc.dataList.length,
              itemBuilder: (BuildContext context,int index){
                String time = RegExp(r"(\d+)").stringMatch(_bloc.dataList[index]['CreateDateTime']);
                String timestr = DateFormat('y-MM-d').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(time)*1000));
                if(widget.type == 'question'){
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       
                        Text('我于${timestr}提问了该问题',
                        style: TextStyle(fontSize: 14,color: Color(0xff999999)),),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _bloc.dataList[index]['ContentTitle'],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            _bloc.dataList[index]['ContentTitle'],
                            style: TextStyle(fontSize: 14,color: Color(0xff464646)),
                          ),
                        ),
                        
                      ],
                    ),
                  );
                }

                if(widget.type == 'favourite'){
                  return HomeItem(_bloc.dataList[index],str: '提问',hasNum:false);
                }

                if(widget.type == 'answer'){
                  print(_bloc.dataList[index]['Answers']);
                  var mine = _bloc.dataList[index]['Answers'].firstWhere((el) => el['UserId']==LocalDataProvider.getInstance().getUserId());
                  print(mine);
                  return Column(
                    children: <Widget>[
                      HomeItem(_bloc.dataList[index],str: '提问',hasNum:false),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 15),
                        color: Colors.lightBlueAccent,
                        child: Text('我于${mine['CreateDateTime']}回答：\n \n       ${mine['Content']}'),
                      )
                    ],
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(){
    if(widget.type == 'question' || widget.type == 'favourite'){

      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(

        ),
      );
    } else {

    }
  }
}