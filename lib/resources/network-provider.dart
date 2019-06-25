import 'dart:async';
import 'base-api-provider.dart';

class NetworkProvider extends BaseApiProvider {

  // 首页
  Future<String> getFeeds() async {
    final response = await get('https://imoocqa.gugujiankong.com/api/feeds/get');
    return response.toString();
  }

  // 发现
  Future<String> getQuestions(Map<String, dynamic> params) async {
    final response = await get('https://imoocqa.gugujiankong.com/api/question/list', params);
    return response.toString();
  }

  // 登录
  Future<String> login(Map<String, dynamic> params) async {
    final response = await get('https://imoocqa.gugujiankong.com/api/account/login', params);
    return response.toString();
  }

  // 注册
  Future<String> register(Map<String, dynamic> params) async {
    final response = await get('https://imoocqa.gugujiankong.com/api/account/register', params);
    return response.toString();
  }

  // 提问
  Future<String> saveQuestion(Map<String, dynamic> params) async {
    final response = await get('https://imoocqa.gugujiankong.com/api/question/save', params);
    return response.toString();
  }
}