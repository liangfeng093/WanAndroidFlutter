import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/bean/Article.dart';
import 'package:wanandroidflutter/network/DataRepository.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/home/BannerWidget.dart';
import 'package:wanandroidflutter/widget/home/ArticleItemWidget.dart';

import '../../main.dart';
import '../ContentPage.dart';
import 'Events.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/26
 * @Description: APP主界面
 */

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeStatus();
  }
}

//class HomeStatus extends State {
class HomeStatus extends BaseView {
  final String TAG = "HomeStatus";

  ///当前页数
  int currentPage = 0;
  List<Article> mArticles = List();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  ScrollController _scrollController = ScrollController();

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
    App.dataRepository.getArticles(currentPage).then((articles) {
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
      setState(() {
        currentState = States.StateSuccess;
      });
    }).catchError((e) {
      setState(() {
        currentState = States.StateException;
      });
      return Future.error(e.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    App.eventBus.on<ScrollToTopEvent>().listen((event) {
      LogUtils.e(TAG, "eventType:" + event.eventType);
      _scrollController.jumpTo(0);
    });
    _scrollController.addListener(() {
      //当前位置是否超过屏幕高度
      if (_scrollController.offset < 200 && showToTopBtn) {
        showToTopBtn = false;
      } else if (_scrollController.offset >= 200 && showToTopBtn == false) {
        showToTopBtn = true;
      }
      App.eventBus.fire(ShowHomeFABEvent(showToTopBtn));
      LogUtils.e(TAG, "showToTopBtn:" + showToTopBtn.toString());
    });
    super.initState();
    //可配置自定义的状态视图
//    emptyView = Text("自定义空视图");
//    exceptionView = Text("自定义异常视图");
//    loadingView = Text("自定义空视图");
  }

  _onClickItem(int position) {
    LogUtils.e(TAG, "position:" + position.toString());
    var article = mArticles[position];
    LogUtils.e(TAG, "title:" + article.title);
    LogUtils.e(TAG, "link:" + article.link);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ContentPage(article.link);
    }));
  }

  @override
  void getData() {
    // TODO: implement getData
    _getArticleData(true);
  }

  @override
  Widget initSuccessView() {
    // TODO: implement initSuccessView
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
          controller: _scrollController,
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

}
