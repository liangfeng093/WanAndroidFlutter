import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/ContentPage.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/dialog/LoadingDialog.dart';
import 'package:wanandroidflutter/widget/home/ArticleItemWidget.dart';
import 'package:wanandroidflutter/widget/knowledge/Knowledge.dart';
import 'package:wanandroidflutter/widget/pub_num/WxArticle.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/4
 * @Description:公众号
 */
class PublicNumberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PublicNumberPageState();
  }
}

enum PNPStates {
  Loading_Left,
  Success_Left,
  Exception_Left,
}

class PublicNumberPageState extends BaseView
    with SingleTickerProviderStateMixin {
  final String TAG = "PublicNumberPageState";

  List<Knowledge> _mTabDatas = [];
  List<WxArticle> _mArticles = [];
  int _selectTabPosition = 0;

  //本页面使用自定义状态
  PNPStates _state = PNPStates.Loading_Left;

  PageController _pageController;

  String currentPubNumId = "408";

  int currentPage = 1;

  var refreshController = RefreshController(initialRefresh: false);
  var scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
    //可配置自定义的状态视图
//    emptyView = _initEmptyView();
//    loadingView = _initLoadingView();
//    exceptionView = _initExceptionView();
  }

  Widget _initEmptyView() {}

  Widget _initLoadingView() {}

  Widget _initExceptionView() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return super.build(context);
  }

  @override
  void getData() {
    getTabs();
    getList(currentPubNumId, "0", _selectTabPosition, false, true);
  }

  void getList(
      String pubNumId, String page, int index, bool isJump, bool isClear) {
    App.dataRepository.getPubNumHistory(pubNumId, page).then((list) {
      setState(() {
        if (isClear) {
          _mArticles.clear();
        }
        _mArticles.addAll(list);
        if (isJump) {
          _pageController.jumpToPage(index);
          Navigator.pop(context);
        }
        refreshController.loadComplete();
      });
    });
  }

  void getTabs() {
    App.dataRepository.getPubNumTab().then((list) {
      LogUtils.e(TAG, "size:" + list.length.toString());
      if (list.length <= 0) {
        return;
      }
      _mTabDatas.clear();
      _mTabDatas.addAll(list);
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
  Widget initSuccessView() {
    // TODO: implement initSuccessView
    return Row(
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _tabLv1(index);
            },
            itemCount: _mTabDatas.length,
          ),
          flex: 1,
        ),
        Flexible(
            flex: 2,
            child: PageView.builder(
                controller: _pageController,
                //禁用滑动
                physics: NeverScrollableScrollPhysics(),
                itemCount: _mTabDatas.length,
                itemBuilder: (BuildContext context, int index) {
                  return SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    header: ClassicHeader(),
                    onRefresh: () {
                      LogUtils.e("SmartRefresher", "下拉刷新");
//                      getList(currentPubNumId, page, index, isJump);
                    },
                    onLoading: () {
                      LogUtils.e("SmartRefresher", "上拉加载");
                      ++currentPage;
                      getList(currentPubNumId, currentPage.toString(),
                          _selectTabPosition, false, false);
                    },
                    controller: refreshController,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        var article = _mArticles[index];
                        var time = DateTime.fromMillisecondsSinceEpoch(
                            article.publishTime);
                        return GestureDetector(
                          onTap: () => _onClickItemLv2(index),
                          child: Container(
                            color: Colors.white,
                            child: ArticleItemWidget(
                                article.title,
                                article.author,
                                time.toString().substring(0, 10)),
                          ),
                        );
                      },
                      itemCount: _mArticles.length,
                      controller: scrollController,
                    ),
                  );
                })),
      ],
    );
  }

  Widget _tabLv1(int index) {
    return GestureDetector(
      onTap: () => _onClickItemLv1(index),
      onDoubleTap: () => _onDoubleItemLv1(index),
      child: Container(
        height: 50,
        color: (_selectTabPosition == index)
            ? Colors.white
            : Color.fromARGB(99, 192, 192, 192),
        child: Center(
          child: Text(
            _mTabDatas[index].name,
            style: TextStyle(),
          ),
        ),
      ),
    );
  }

  _onClickItemLv1(int index) {
    //展示loading对话框
    if (index != _selectTabPosition) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingDialog();
          });
      setState(() {
        currentPage = 1; //重置页数
        _selectTabPosition = index;
        currentPubNumId = _mTabDatas[index].id.toString();
        getList(currentPubNumId, "0", index, true, true);
      });
    }
  }

  _onDoubleItemLv1(int index) {
    //展示loading对话框
    scrollController.jumpTo(0);
    /*setState(() {
      currentPage = 1; //重置页数
      _selectTabPosition = index;
      currentPubNumId = _mTabDatas[index].id.toString();
      getList(currentPubNumId, "0", index, true, true);
    });*/
  }

  _onClickItemLv2(int index) {
    var article = _mArticles[index];
    LogUtils.e(TAG, "title:" + article.title);
    LogUtils.e(TAG, "link:" + article.link);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ContentPage(article.link);
    }));
  }
}
