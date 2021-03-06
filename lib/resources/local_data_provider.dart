
import 'package:flutter_zhihu/resources/shared_preferences.dart';
import 'package:flutter_zhihu/utils/date_util.dart';

class UserBriefModel {
  String userId;
  String userNickName;
  String userHeadface;
  String phone;
  String password;
}

class LocalDataProvider {
  UserBriefModel _briefInfo;
  SpUtil sp;

  static LocalDataProvider _instance;

  static bool _isAndroid = true;
  static int _remindTime = 0;
  static int _loginTime = 0;

  // 单利
  static LocalDataProvider getInstance() {
    if (_instance == null) {
      _instance = LocalDataProvider();
    }
    return _instance;
  }

  initData() async {
    sp = await SpUtil.getInstance();
    _remindTime = sp.getInt(SharedPreferencesKeys.remindTime);
    _loginTime = sp.getInt(SharedPreferencesKeys.loginTime);
    _briefInfo = UserBriefModel();
    initBriefInfo();
  }

  initBriefInfo() {
    _briefInfo.userId = sp.getString(SharedPreferencesKeys.userId);
    _briefInfo.userNickName = sp.getString(SharedPreferencesKeys.userNickName);
    _briefInfo.userHeadface =
        sp.getString(SharedPreferencesKeys.userHeadface);
    _briefInfo.phone = sp.getString(SharedPreferencesKeys.phone);
    _briefInfo.password = sp.getString(SharedPreferencesKeys.password);

  }

  saveUserInfo(userId,userNickName,userHeadface,phone,password) async {
    sp.putString(SharedPreferencesKeys.userId, userId);
    sp.putString(SharedPreferencesKeys.userNickName, userNickName);
    sp.putString(SharedPreferencesKeys.userHeadface, userHeadface);
    sp.putString(SharedPreferencesKeys.phone, phone);
    sp.putString(SharedPreferencesKeys.password, password);
    initBriefInfo();
  }
  bool isLogin() {
    if (null == _briefInfo) {
      return false;
    } else {
      if (null == _loginTime) {
        return false;
      } else {
        if ((DateUtils.getNowDateMs() - _loginTime) > 3 * 86400000) {
          // 三天以后，登录信息没有用
          return false;
        } else {
          // 三天以内，登录信息有用
          return true;
        }
      }
    }
  }


  setIos() {
    _isAndroid = false;
  }

  isAndroid() {
    return _isAndroid;
  }


  int getLoginTime() {
    return _loginTime;
  }

  setLoginTime(int time) {
    _loginTime = time;
  }


  int getRemindTime() {
    return _remindTime;
  }

  setRemindTime(int time) {
    _remindTime = time;
  }

  getUserId() {
    return _briefInfo.userId;
  }

  getUserNickName() {
    return _briefInfo.userNickName;
  }

  getUserHeadface() {
    return _briefInfo.userHeadface;
  }


  String getPokeMeTime(String key) {
    return sp.get('pokeMeTime');
  }



  clearAll() {
    _briefInfo.userId = null;
    _briefInfo.userNickName = null;
    _briefInfo.userHeadface = null;
    sp.clear();
  }


}
