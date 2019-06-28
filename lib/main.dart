import 'package:flutter/material.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/HomeWidget.dart';
import 'package:wanandroidflutter/widget/page_view.dart';

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
    return MaterialApp(title: 'Flutter Demo', home: Main());
  }
}

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainState();
  }
}

class MainState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                color: Colors.grey,
                child: Center(
                  child: Image.asset(
                    "assets/app_icon.png",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
//              Icon(Icons.add),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "首页",
            style: TextStyle(),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: MyPageView(
          //禁用滑动
          physics: NeverScrollableScrollPhysics(),
          controller: _pageControllerageController,
          children: <Widget>[
            Home(),
            Text("this is 2 page"),
          ],
        ));
  }

  MyPageController _pageControllerageController = MyPageController();

  int _currentIndex = 0;

  BottomNavigationBar _buildBottomNavigationBar() {
    BottomNavigationBar _bottomNavigationBar = BottomNavigationBar(
      currentIndex: _currentIndex, //默认选中位置
      onTap: (index) {
        LogUtils.e("BottomNavigationBar===>", "index:" + index.toString());
        switch (index) {
          case 0:
            {
              _pageControllerageController.jumpToPage(index);
              break;
            }
          case 1:
            {
              _pageControllerageController.jumpToPage(index);
              break;
            }
        }
        setState(() {
          _currentIndex = index;
          LogUtils.e(
              "BottomNavigationBar===>", "_currentIndex:" + index.toString());
        });
      },
      items: [
        BottomNavigationBarItem(title: Text("首页"), icon: Icon(Icons.home)),
        BottomNavigationBarItem(title: Text("首页"), icon: Icon(Icons.home)),
      ],
    );
    return _bottomNavigationBar;
  }
}
