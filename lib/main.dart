import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroidflutter/DataContainer.dart';
import 'package:wanandroidflutter/RemoteApi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    getHttp();

    var data = RemoteApi.getInstance().get("/article/list/0/json",Options(responseType: ResponseType.plain));

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
}

void getHttp() async {
  try {
    Response response = await Dio().get(
        "https://www.wanandroid.com/article/list/0/json",
        options: Options(responseType: ResponseType.plain));

    ArticleList articleList = DataContainer<ArticleList>(
        response.data, (res) => ArticleList.fromJson(res)).data;

    print("articleList:" + articleList.toString());
//    print("errorMsg:" + response.data.containsKey("errorMsg").toString());
//    print("curPage:" + response.data.containsKey("curPage").toString());
//    print("keys:" + response.data.keys.toString());
//    print("keys:" + response.data.keys.);
//    print(response.data is DataContainer);
    print(response);
  } catch (e) {
    print(e);
  }
}
