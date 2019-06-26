import 'package:flutter/material.dart';
import 'package:wanandroidflutter/widget/HomeWidget.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  final String TAG = "MyApp";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}
