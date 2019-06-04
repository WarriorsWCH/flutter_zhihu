import 'dart:async';
import 'base-api-provider.dart';

class NetworkProvider extends BaseApiProvider {


  Future<String> getFeeds() async {
    final response = await get('https://imoocqa.gugujiankong.com/api/feeds/get');
    return response.toString();
  }

}