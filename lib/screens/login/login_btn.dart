import 'package:flutter/material.dart';

class LoginBtn extends StatefulWidget{
  final Function() press;
  Color bgColor;
  Color fontColor;
  String name;
  LoginBtn({
      this.press,
      this.bgColor,
      this.fontColor,
      this.name
    }
  );
  @override
  _loginBtnState createState() {
    return _loginBtnState();
  }
}

class _loginBtnState extends State<LoginBtn> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: RaisedButton(
        onPressed: () {
          widget.press();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        color: widget.bgColor,
        child: Container(
          height: 44,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(widget.name,
              style: TextStyle(
                fontSize: 18.0, 
                color: widget.fontColor, 
              )),
        ),
      ));
  }
}