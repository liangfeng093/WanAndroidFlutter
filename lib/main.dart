import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/ContentPage.dart';
import 'package:wanandroidflutter/widget/home/HomePage.dart';
import 'package:wanandroidflutter/widget/page_view.dart';

//void main() => runApp(App());
void main() {
  /// 强制竖屏
  ///
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(App());
}

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
    return MaterialApp(
      title: 'Flutter Demo',
//      home: Main(),
      initialRoute: "/", //初始路由
      routes: {
        "/": (BuildContext content) => Main(),
        "/0": (BuildContext content) => Text("this is route 1"),
        "/1": (BuildContext content) => Text("this is route 1"),
        "/2": (BuildContext content) => Text("this is route 2"),
        "/3": (BuildContext content) => Text("this is route 3"),
        "/4": (BuildContext content) => Text("this is route 4"),
      },
    );
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
            HomePage(),
            Text("this is 2 page"),
            Text("this is 3 page"),
            Text("this is 4 page"),
            Text("this is 5 page"),
          ],
        ));
  }

  MyPageController _pageControllerageController = MyPageController();

  int _currentIndex = 0;

  BottomNavigationBar _buildBottomNavigationBar() {
    BottomNavigationBar _bottomNavigationBar = BottomNavigationBar(
      currentIndex: _currentIndex, //默认选中位置
      type: BottomNavigationBarType.fixed,
//      fixedColor: Colors.blue,
      onTap: (index) {
        LogUtils.e("BottomNavigationBar===>", "index:" + index.toString());
        switch (index) {
          case 0:
            {
              _pageControllerageController.jumpToPage(index);
//              Navigator.pushNamed(context, "/0");
              break;
            }
          case 1:
            {
              _pageControllerageController.jumpToPage(index);
//              Navigator.pushNamed(context, "/1");
              break;
            }
          case 2:
            {
              _pageControllerageController.jumpToPage(index);
//              Navigator.pushNamed(context, "/2");
              break;
            }
          case 3:
            {
              _pageControllerageController.jumpToPage(index);
//              Navigator.pushNamed(context, "/3");
              break;
            }
          case 4:
            {
              _pageControllerageController.jumpToPage(index);
//              Navigator.pushNamed(context, "/4");
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
        BottomNavigationBarItem(title: Text("知识体系"), icon: Icon(Icons.widgets)),
        BottomNavigationBarItem(title: Text("公众号"), icon: Icon(Icons.camera)),
        BottomNavigationBarItem(title: Text("项目"), icon: Icon(Icons.computer)),
      ],
    );
    return _bottomNavigationBar;
  }
}
