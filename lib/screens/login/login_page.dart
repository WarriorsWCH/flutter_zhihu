import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zhihu/resources/local_data_provider.dart';
import 'package:flutter_zhihu/resources/network-provider.dart';
import 'package:flutter_zhihu/screens/home/home_page.dart';
import 'package:flutter_zhihu/screens/login/register_page.dart';
import 'package:flutter_zhihu/screens/tabs/tabs.dart';
import 'package:flutter_zhihu/utils/ui_util.dart';
import 'package:flutter_zhihu/utils/validators.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'login_btn.dart';
import 'login_input.dart';

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
      resizeToAvoidBottomInset:false,
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
          LoginPut(save:(val){
            passwordLoginInfo.phone = val;
          },img:'assets/phone.png',name:'手机号码'),

          LoginPut(save:(val){
            passwordLoginInfo.password = val;
          },img:'assets/lock.png',name:'密码'),

          LoginBtn(press: (){
            _loginByPassword();
          },bgColor: Color(0xff488aff),fontColor: Color(0xffffffff),name: '登录',),
           LoginBtn(press: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegisterPage()
            ));
          },bgColor: Color(0xffEEEEEE),fontColor: Color(0xff333333),name: '注册',),

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
          LocalDataProvider.getInstance().saveUserInfo(
            data['UserId'],data['UserNickName'],data['UserHeadface'],passwordLoginInfo.phone,passwordLoginInfo.password);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>Tabs()
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