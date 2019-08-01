import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/DrawerMenu.dart';
import 'package:wanandroidflutter/widget/home/Events.dart';
import 'package:wanandroidflutter/widget/home/HomePage.dart';
import 'package:wanandroidflutter/widget/knowledge/KnowledgePage.dart';
import 'package:wanandroidflutter/widget/page_view.dart';
import 'package:wanandroidflutter/widget/pub_num/PublicNumberPage.dart';
import 'package:wanandroidflutter/widget/search/SearchPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/DataRepository.dart';

//void main() => runApp(App());
void main() {
  /// 强制竖屏
  ///
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  App.getPrimaryColor().then((color) {
    App.primaryColor = Color(color);
    runApp(App());
  });
}

class AppConfig {
  static final String PRIMARY_COLOR = "PrimaryColor";
}

class App extends StatefulWidget {
  static EventBus eventBus = new EventBus();
  static DataRepository dataRepository = DataRepository();

  static Color primaryColor = Colors.tealAccent;

  final String TAG = "MyApp";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppState();
  }

  static Future<int> getPrimaryColor() async {
    var sp = await SharedPreferences.getInstance();
    int color = sp.getInt(AppConfig.PRIMARY_COLOR) ?? Colors.grey;
    return color;
  }
}

class AppState extends State<App> {
  final String TAG = "AppState";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    App.eventBus.on<ThemEvent>().listen((event) {
      setState(() {
        LogUtils.e(TAG, "切换主题色:" + event.primaryColor.toString());
        _savePrimaryColor(event.primaryColor.value);
        App.primaryColor = event.primaryColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    App.dataRepository.getFriendUrl();
//    App.dataRepository.getHotWord();
    var list = App.dataRepository.getProjectTypes();
    LogUtils.e(TAG, "");

    return MaterialApp(
      theme: ThemeData(primaryColor: App.primaryColor),
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

  _savePrimaryColor(int color) async {
    var sp = await SharedPreferences.getInstance();
    await sp.setInt(AppConfig.PRIMARY_COLOR, color);
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
  final String TAG = "MainState";

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  var titles = [
    "首页",
    "知识体系",
    "公众号",
    "项目",
    "",
    "",
  ];
  var _title = "";

  @override
  void initState() {
    // TODO: implement initState
    _title = titles[0];
    App.eventBus.on<ShowHomeFABEvent>().listen((event) {
      setState(() {
        if (event.isShow) {
          setState(() {
            showToTopBtn = true;
          });
        } else {
          setState(() {
            showToTopBtn = false;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.tealAccent,
                  child: Center(
                    /*child: Image.asset(
                        "assets/app_icon.png",
                        height: 100,
                        width: 100,
                      ),*/
                    child: Icon(
                      Icons.android,
                      size: 180.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: DrawerMenu(),
                flex: 5,
              ),
              /*Container(
                  height: 200,
                  color: Colors.grey,
                  child: Center(
                    child: Image.asset(
                      "assets/app_icon.png",
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),*/
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _title,
            style: TextStyle(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SearchPage();
                }));
              },
            )
          ],
        ),
        floatingActionButton: showToTopBtn
            ? FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  App.eventBus.fire(ScrollToTopEvent(ScrollToTopEvent.HOME));
                },
              )
            : null,
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: MyPageView(
          //禁用滑动
          physics: NeverScrollableScrollPhysics(),
          controller: _pageControllerageController,
          children: <Widget>[
            HomePage(),
            KnowledgePage(),
            PublicNumberPage(),
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
              break;
            }
          case 1:
            {
              _pageControllerageController.jumpToPage(index);
              break;
            }
          case 2:
            {
              _pageControllerageController.jumpToPage(index);
              break;
            }
          case 3:
            {
              Tooltip(message: "点击项目tab");
              _pageControllerageController.jumpToPage(index);
              break;
            }
          case 4:
            {
              _pageControllerageController.jumpToPage(index);
              break;
            }
        }
        setState(() {
          _currentIndex = index;
          _title = titles[index];
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
