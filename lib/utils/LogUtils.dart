import 'package:dio/dio.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/18
 * @Description:
 */
class LogUtils {
  ///info
  static i(String Tag, Object obj) {
    print("【Info】"+Tag + ":" + obj.toString());
  }

  ///error
  static e(String Tag, Object obj) {
    print("【Error】"+Tag + ":" + obj.toString());
  }

  ///判断响应体的类型是否为Map类型
  static bool responseIsMap(Response response) {
    print("response type is Map:" + (response.data is Map).toString());
  }

  ///判断响应体的类型是否为Map类型
  static bool responseIsList(Response response) {
    print("response type is List:" + (response.data is List).toString());
  }
}
