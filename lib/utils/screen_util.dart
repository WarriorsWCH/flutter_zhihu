import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  //设计稿的设备尺寸修改
  int width;
  int height;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  ScreenUtil({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  ///设备的像素密度
  static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  static double get screenWidthDp => _screenWidth;

  ///当前设备高度 dp
  static double get screenHeightDp => _screenHeight;

  ///当前设备宽度 px
  static double get screenWidth => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  static double get screenHeight => _screenHeight * _pixelRatio;

  ///状态栏高度 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight * _pixelRatio;

  ///底部安全区距离
  static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  ///实际的dp与设计稿px的比例
  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  setWidth(int width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  setHeight(int height) => height * scaleHeight;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  setSp(int fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}

const UIWidth=375;// 设计稿宽度
const UIHeight=667;// 设计稿高度
num uiBase=UIWidth;
num uiBaseHeight = UIHeight;

/// 获取等比例的宽度, 参数默认是1倍的设计稿单位，如果量出来的单位是2倍的用px2,3倍的用px3
/// width:px(30);1倍
/// width:px(null,px2:60);2倍
num px(num  px,{px2,px3}){
  num screeHeight = window.physicalSize.height/window.devicePixelRatio;
  num screenWidth = window.physicalSize.width/window.devicePixelRatio;
  if(screenWidth > screeHeight){// 如果是横屏的情况需要改变基准
    uiBase=UIHeight;
  }else{
    uiBase=UIWidth;
  }
  if(px!=null){
    return px/uiBase * screenWidth;
  }
  if(px2!=null){
    return (px2/2)/uiBase * screenWidth;
  }
  if(px3!=null){
    return px3/3/uiBase * screenWidth;
  }
  return px/uiBase * screenWidth;
}
// 获取等比例的高度
num pxh(num px,{px2,px3}){
  num screeHeight = window.physicalSize.height/window.devicePixelRatio;
  num screenWidth = window.physicalSize.width/window.devicePixelRatio;
  if(screenWidth > screeHeight){// 如果是横屏的情况需要改变基准
    uiBaseHeight = UIWidth;
  }else{
    uiBaseHeight = UIHeight;
  }
  if(px!=null){
    return px/uiBaseHeight * screeHeight;
  }
  if(px2!=null){
    return (px2/2)/uiBaseHeight* screeHeight;
  }
  if(px3!=null){
    return px3/3/uiBaseHeight* screeHeight;
  }
  return px/uiBaseHeight* screeHeight;
}

num fontSize(num px,{allowFontScaling = false}){
  num screeHeight = window.physicalSize.height/window.devicePixelRatio;
  num screenWidth = window.physicalSize.width/window.devicePixelRatio;
  if(allowFontScaling){
    return px/uiBase*screenWidth/window.textScaleFactor;
  }
  return px/uiBase*screenWidth;
}



num pxmax(num  px, num max,{px2,px3}){
  num screeHeight = window.physicalSize.height/window.devicePixelRatio;
  num screenWidth = window.physicalSize.width/window.devicePixelRatio;
  if(screenWidth > screeHeight){// 如果是横屏的情况需要改变基准
    uiBaseHeight = UIWidth;
  }else{
    uiBaseHeight = UIHeight;
  }
  if(px!=null && max!=null){
    return px/uiBase*screenWidth > max ? max.toDouble() : px/uiBase*screenWidth;
  }
  if(px2!=null && max!=null){
    return (px2/2)/uiBase*screenWidth> max ?  max.toDouble() : px/uiBase*screenWidth;
  }
  if(px3!=null && max!=null){
    return px3/3/uiBase*screenWidth> max ?  max.toDouble() : px/uiBase*screenWidth;
  }
  return px/uiBase*screenWidth> max ?  max.toDouble() : px/uiBase*screenWidth;
}