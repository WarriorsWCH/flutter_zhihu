class Validators {
  /// 手机号码验证器
  static bool phone(String phone) {
    if (null == phone) {
      return false;
    }

    return new RegExp('^1[3|4|5|6|7|8|9][0-9]{9}\$').hasMatch(phone);
  }

  /// 验证中文名是不是合法
  static bool isChineseName(String name) {
    if (null == name) {
      return false;
    }
    return new RegExp('^[\u4e00-\u9fa5\·]{2,20}\$').hasMatch(name);
  }

  /// 验证英文名是不是合法
  static bool isEnName(String name) {
    if (null == name) {
      return false;
    }
    return new RegExp('^[a-zA-Z ]{2,20}\$').hasMatch(name);
  }

  /// 英文名不能是baby，或者大写的baby
  static bool isNotBaby(String name) {
    if (null == name) {
      return false;
    }

    if ('' == name) {
      return false;
    }

    return name.toLowerCase() != 'baby';
  }

  static bool required(String value) {
    return value != null && value.isNotEmpty;
  }
}
