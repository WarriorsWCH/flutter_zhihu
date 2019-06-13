import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// 用来做shared_preferences的存储
class SpUtil {
  static SpUtil _instance;

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  static SharedPreferences _spf;

  SpUtil._(); // 声明一个命名构造函数

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      _instance = new SpUtil._();
      await _instance._init();
    }
    return _instance;
  }

  static bool _beforCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (_beforCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforCheck()) return null;
    return _spf.get(key);
  }

  getString(String key) {
    if (_beforCheck()) return null;
    return _spf.getString(key);
  }

  Future<bool> putString(String key, String value) {
    if (_beforCheck()) return null;
    return _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforCheck()) return null;
    return _spf.getBool(key);
  }

  Future<bool> putBool(String key, bool value) {
    if (_beforCheck()) return null;
    return _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforCheck()) return null;
    return _spf.getInt(key);
  }

  Future<bool> putInt(String key, int value) {
    if (_beforCheck()) return null;
    return _spf.setInt(key, value);
  }

  double getDouble(String key) {
    if (_beforCheck()) return null;
    return _spf.getDouble(key);
  }

  Future<bool> putDouble(String key, double value) {
    if (_beforCheck()) return null;
    return _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  Future<bool> putStringList(String key, List<String> value) {
    if (_beforCheck()) return null;
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforCheck()) return null;
    return _spf.clear();
  }
}


class SharedPreferencesKeys {
  /// boolean
  /// 用于欢迎页面. 只有第一次访问才会显示. 或者手动将这个值设为false
  static String showWelcome = 'showWelcome';

  static String userId = 'userId';
  static String userNickName = 'userNickName';
  static String userHeadface = 'userHeadface';


  /// 保存"关闭提示信息"的时间
  static String remindTime = 'remindTime';

  /// 保存"登录"的时间
  static String loginTime = 'loginTime';

}
