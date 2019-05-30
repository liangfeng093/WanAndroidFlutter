import 'dart:io';

import 'package:dio/dio.dart';

class RemoteApi {
  final BASE_URL = "https://www.wanandroid.com";

  Dio _dio;

  static RemoteApi _instance;
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";

  /**
   * 单例模式
   */
  static RemoteApi getInstance() {
    if (_instance == null) {
      _instance = RemoteApi();
    }
    return _instance;
  }

  RemoteApi() {
    //网络请求的配置
    BaseOptions options = new BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {},
      contentType: ContentType.json,
      responseType: ResponseType.plain,
    );
    _dio = new Dio(options);
    //添加拦截器
    _dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 在请求被发送之前做一些事情
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理
      return response; // continue
    }, onError: (DioError e) {
      // 当请求失败时做一些预处理
      return e; //continue
    }));
  }

  /**
   * get请求
   */
  get(String url, Options options) async {
    Response response;
    try {
      response = await _dio.get(url);
      print("======>response:" + response.toString());
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    return response;
  }
}


