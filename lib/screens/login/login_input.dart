import 'package:flutter/material.dart';

class LoginPut extends StatefulWidget {
  final Function(dynamic) save;
  String img;
  String name;
  LoginPut({this.save, this.img, this.name});
  @override
  _loginPutState createState() {
    return _loginPutState();
  }
}

class _loginPutState extends State<LoginPut> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)))),
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(widget.img),
            width: 12,
            height: 16,
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (val) {
                        widget.save(val);
                      },
                      onFieldSubmitted: (val) {
                        // _loginByPassword();
                      },
                      style: TextStyle(color: Color(0xFF000000)),
                      // 设置字体样式
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFFC2C2C2)),
                          hintText: widget.name),
                      obscureText: true))),
        ],
      ),
    );
  }
}
