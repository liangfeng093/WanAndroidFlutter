import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroidflutter/network/DataContainer.dart';
import 'package:wanandroidflutter/RemoteApi.dart';
import 'package:wanandroidflutter/network/DataRepository.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String TAG = "MyApp";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DataRepository repository = DataRepository();
    //then方法:注册一个Future回调
    //当getBanner返回Future时出发then回调
    repository.getBanner().then((list){
      //
      list;
    });

    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "首页",
              style: TextStyle(),
            ),
          ),
          body: Center(
            child: Text("hello world"),
          ),
        ));
  }

  void getHttp() async {
    try {
      Response<Map<String, dynamic>> response =
          await Dio().get("https://www.wanandroid.com/article/list/0/json");

      LogUtils.responseIsMap(response);
      LogUtils.responseIsList(response);
      LogUtils.i(TAG, response);
      print(response.data.keys.toString());
      print(response.data.values.toString());
      print(response.data.containsKey("errorMsg"));
      Map map = response.data["data"];
      print(map["curPage"]);
      print(map["datas"]);
      print(response.data["errorCode"]);
      print(response.data["errorMsg"].toString().isEmpty);
    } catch (e) {
      print(e);
    }
  }
}
