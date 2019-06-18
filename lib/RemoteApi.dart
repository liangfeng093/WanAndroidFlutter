import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wanandroidflutter/network/DataContainer.dart';

class RemoteApi {
  final BASE_URL = "https://www.wanandroid.com";

  Dio _dio;

  static RemoteApi _instance;
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";

  ///网络请求状态码:200、404等等
  String _statusKey = "";

  ///网络请求结果码:表示请求成功或失败
  String _cedoKey = "errorCode";

  ///网络请求结果说明:成功或失败的原因
  String _msgKey = "errorMsg";

  ///网络请求数据集
  String _dataKey = "data";

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

  ///配置http请求
  ///requestType
  ///Future 表示一个延时对象
  Future<DataContainer<T>> request<T>(String requestType, String path,
      {Options options}) async {
    ///校验options
    if (options == null) {
      options = Options();
    }
    options.
    options.method = requestType; //设置请求类型

    Response response = await _dio.request(path, options: options);
    String _status; //
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok) {
      try {
        if (response.data is Map) {
          //data作为map处理
          //解析json最外层字段
          if (response.data["errorCode"] is int) {
            _code = response.data["errorCode"];
          } else {
            _code = int.parse(response.data["errorCode"]);
          }
          _msg = response.data["errorMsg"];
          _data = response.data["data"];
        } else {
          //data作为字符串处理
          Map<String, dynamic> _dataMap = json.decode(response.data.toString());
          if (_dataMap["errorCode"] is int) {
            _code = _dataMap["errorCode"];
          } else {
            _code = int.parse(_dataMap["errorCode"]);
          }
          _msg = _dataMap["errorMsg"];
          _data = _dataMap["data"];
        }
        return DataContainer<T>(_code, _msg, _data);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          message: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    } else {}
  }

  /**
   * get请求
   */
  Future get(String url, Options options) async {
    //async会让整个方法中的逻辑都异步
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

  /**
   * f
   */
  Future getArticleList(String url, Options options) async {}
}

class RequestType {
  static final String GET = "GET";
  static final String POST = "POST";
}
