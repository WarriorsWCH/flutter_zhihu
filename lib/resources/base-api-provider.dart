import 'dart:async';

import 'package:dio/dio.dart';


class BaseApiProvider {
  Dio dio = new Dio();


  BaseApiProvider() {
    dio.options.connectTimeout = 50000; //10s
    dio.options.receiveTimeout = 30000;

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {


      return options; //continue

    }, onResponse: (Response response) {

      return response; // continue
    }));
  }

  post(url, [var params]) async {
    Completer myComplete =Completer();
    dio.post(url, data:params).then((res){
      print('res---$res');
      myComplete.complete(res);
    }).catchError((error){
      myComplete.complete(_handleError(error));
    });
    return myComplete.future;
  }

  get(url, [var params]) {
    Completer myComplete = Completer();
    dio.get(url, queryParameters: params).then((res){
      myComplete.complete(res);
    }).catchError((error){
      myComplete.complete(_handleError(error));
    });
    return myComplete.future;
  }

  _handleError( dynamic error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription =
          "SEND_TIMEOUT";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }


    return {'code': 40001,'result': false, 'msg': errorDescription};

  }

}
