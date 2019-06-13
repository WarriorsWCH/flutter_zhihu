import 'package:flutter/material.dart';
import 'package:flutter_zhihu/utils/validators.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      var params = {
        'mobile': passwordLoginInfo.phone,
        'password': passwordLoginInfo.password
      };
      showLoginDialog();
      // loginBloc.loginByPassword(params).then((BaseResp res) {
      //   pr.hide();
      //   if (res.result) {
      //     UserModel userModel = UserModel.fromJson(res.data);
      //     loginBloc.saveUserInfo(userModel);

      //     if (null == userModel.studentList[0].enName ||
      //         !Validators.isNotBaby(userModel.studentList[0].enName)) {
      //       // 如果用户英文名不符合规则，那就去完善信息页面
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => CompleteInfoPage(
      //             password: passwordLoginInfo.password,
      //             type: CompleteInfoType.passwordLogin),
      //       ));
      //     } else {
      //       toHomePage(context);
      //     }
      //   } else {
      //     UiUtil.showToast(res.msg);
      //   }
      // });
    } else if (!Validators.phone(passwordLoginInfo.phone)) {
      Fluttertoast.showToast(
        msg: '请输入正确的手机号码',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(0x88000000),
        textColor: Colors.white,
        fontSize: 14.0);
    } else {
     Fluttertoast.showToast(
        msg: '请输入正确的密码',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(0x88000000),
        textColor: Colors.white,
        fontSize: 14.0);
    }
  }

  showLoginDialog() {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('正在登录...');
    pr.show();
  }
}