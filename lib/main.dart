import 'package:flutter/material.dart';
import 'package:wanandroidflutter/network/DataRepository.dart';
import 'package:wanandroidflutter/widget/BannerWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final String TAG = "MyApp";

  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            drawer: Drawer(
              child: Text("777"),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "首页",
                style: TextStyle(),
              ),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  child: BannerWidget(),
                  height: 200,
                )
              ],
            )));
  }
}
