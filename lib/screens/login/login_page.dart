import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zhihu/resources/local_data_provider.dart';
import 'package:flutter_zhihu/resources/network-provider.dart';
import 'package:flutter_zhihu/screens/home/home_page.dart';
import 'package:flutter_zhihu/utils/ui_util.dart';
import 'package:flutter_zhihu/utils/validators.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PasswordLoginInfo {
  String phone;
  String password;
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{

  final _apiClient = NetworkProvider();
  ProgressDialog pr;
  
  GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  PasswordLoginInfo passwordLoginInfo = PasswordLoginInfo();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
          child: _buildPasswordForm(),
        ),
      ),
    );
  }

  // 密码登录的
  _buildPasswordForm() {
    return Form(
      key: _passwordFormKey,
      child: Column(
        children: <Widget>[
          Container(
            child: Text('登录',style: TextStyle(fontSize: 24),),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)))),
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/phone.png'),
                  width: 12,
                  height: 16,
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onSaved: (val) {
                            passwordLoginInfo.phone = val;
                          },
                          style: TextStyle(color: Color(0xFF000000)),
                          // 设置字体样式
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Color(0xFFC2C2C2)),
                              hintText: '手机号码'),
                        ))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)))),
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/lock.png'),
                  width: 12,
                  height: 16,
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (val) {
                              passwordLoginInfo.password = val;
                            },
                            onFieldSubmitted: (val) {
                              // _loginByPassword();
                            },
                            style: TextStyle(color: Color(0xFF000000)),
                            // 设置字体样式
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    TextStyle(color: Color(0xFFC2C2C2)),
                                hintText: '密码'),
                            obscureText: true))),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 40),
              child: RaisedButton(
                onPressed: () {
                  _loginByPassword();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color(0xff488aff),
                child: Container(
                  height: 44,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('登录',
                      style: TextStyle(
                        fontSize: 18.0, 
                        color: const Color(0xffffffff), 
                      )),
                ),
              )),

          Container(
              margin: EdgeInsets.only(top: 40),
              child: RaisedButton(
                onPressed: () {
                  
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color(0xffEEEEEE),
                child: Container(
                  height: 44,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('注册',
                      style: TextStyle(
                        fontSize: 18.0, 
                        // color: const Color(0xffffffff), 
                      )),
                ),
              )),
        ],
      ),
    );
  }


   _loginByPassword() async {
    //验证
    final form = _passwordFormKey.currentState;
    form.save();
    if (Validators.phone(passwordLoginInfo.phone) &&
        Validators.required(passwordLoginInfo.password)) {
      showLoginDialog();
      _apiClient.login({
        'mobile':passwordLoginInfo.phone,
        'password':passwordLoginInfo.password
      }).then((res) {
        pr.hide();
        print(res);
        var data = json.decode(res);
        if (data['Status'] == 'OK'){
          LocalDataProvider.getInstance().saveUserInfo(data['UserId'],data['UserNickName'],data['UserHeadface']);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>HomePage()
          ));
        } else {
          UiUtil.showToast(data['StatusContent']);
        }

      });
    } else if (!Validators.phone(passwordLoginInfo.phone)) {
      UiUtil.showToast('请输入正确的手机号码');
    } else {
      UiUtil.showToast('请输入验证码');
    }
  }

  showLoginDialog() {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('正在登录...');
    pr.show();
  }
}