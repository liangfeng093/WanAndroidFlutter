import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/bean/Article.dart';
import 'package:wanandroidflutter/network/DataRepository.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/BannerWidget.dart';
import 'package:wanandroidflutter/widget/home/ArticleItemWidget.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/26
 * @Description: APP主界面
 */

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeStatus();
  }
}

class HomeStatus extends State {
  final String TAG = "HomeStatus";

  ///当前页数
  int currentPage = 0;
  List<Article> mArticles = List();
  DataRepository repository = DataRepository();
  var refreshController = RefreshController(initialRefresh: false);

  _getArticleData(bool isRefresh) {
    if (isRefresh) {
      mArticles.clear();
      currentPage = 0;
    } else {
      //上拉加载
      currentPage++;
    }
    //then方法:注册一个Future回调
    //当getBanner返回Future时出发then回调
    LogUtils.e("currentPage:", currentPage);
    repository.getArticles(currentPage).then((articles) {
      if (articles.length > 0) {
        if (isRefresh) {
          articles.forEach((item) {
            mArticles.add(item);
          });
          refreshController.refreshCompleted();
        } else {
          articles.forEach((item) {
            mArticles.add(item);
          });
          refreshController.loadComplete();
        }
      } else {
        if (isRefresh) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getArticleData(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(),
      onRefresh: () {
        LogUtils.e("SmartRefresher", "下拉刷新");
        _getArticleData(true);
        //延时三秒
        /* Future.delayed(Duration(seconds: 2), () {
              refreshController.refreshFailed();
            });*/
      },
      onLoading: () {
        LogUtils.e("SmartRefresher", "上拉加载");
        _getArticleData(false);
      },
      controller: refreshController,
      child: ListView.builder(
          itemCount: mArticles.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                height: 200,
                child: BannerWidget(),
              );
            }
            if (mArticles.length > 0) {
              var article = mArticles[index];
              var time =
                  DateTime.fromMillisecondsSinceEpoch(article.publishTime);
              return Container(
                  //此处的padding实际上做出来margin的效果
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: GestureDetector(
                    onTap: () => _onClickItem(index),
                    child: ArticleItemWidget(article.title, article.author,
                        time.toString().substring(0, 10)),
                  ));
            } else {
              return Container(
                height: 50,
                child: Center(child: Text("未获取到数据")),
              );
            }
          }),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1, //默认选中位置
      onTap: (index) {
        LogUtils.e("BottomNavigationBar===>", "index:" + index.toString());
      },
      items: [
        BottomNavigationBarItem(title: Text("首页"), icon: Icon(Icons.home)),
        BottomNavigationBarItem(title: Text("首页"), icon: Icon(Icons.home)),
      ],
    );
  }

  _onClickItem(int position) {
    LogUtils.e(TAG, "position:" + position.toString());
    var article = mArticles[position];
    LogUtils.e(TAG, "title:" + article.title);
  }

  _addDrawerChildren() {
    List<Widget> widgets = List();
    var drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("ID"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
//        backgroundImage: AssetImage("assets/app_icon.png"),
        backgroundImage: NetworkImage(
            "https://www.wanandroid.com/resources/image/pc/logo.png",
            scale: 15),
//        backgroundImage: AssetImage("assets/user_icon.jpg"),
      ),
    );
//    widgets.add(drawerHeader);
    widgets.add(Stack());

    return widgets;
  }
}
