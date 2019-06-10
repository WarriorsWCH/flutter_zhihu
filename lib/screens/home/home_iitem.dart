import 'package:flutter/material.dart';
import 'package:flutter_zhihu/utils/screen_util.dart';

class HomeItem extends StatefulWidget{
  final Map<String,dynamic> data;
  String str;
  HomeItem(this.data,{this.str = '回答'});

  @override
  _HomeItemState createState() {
    return _HomeItemState();
  }
}

class _HomeItemState extends State<HomeItem>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: px(30),
                height: px(30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.data['HeadFace']),
                      fit: BoxFit.fitHeight
                  ),
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
              
              Text('${widget.data['UserNickName']}${widget.str}了该问题',style: TextStyle(fontSize: 14,color: Color(0xff999999)),),

              Spacer(),
            ],
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.data['ContentTitle'],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              widget.data['ContentSummary'],
              style: TextStyle(fontSize: 14,color: Color(0xff464646)),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: Text(
                '${widget.data['LikeCount']} 赞同  ·  ${widget.data['CommentCount']} 评论 ',
              style: TextStyle(fontSize: 14,color: Color(0xff999999)),
            ),
          )
        ],
      ),
    );
  }
}