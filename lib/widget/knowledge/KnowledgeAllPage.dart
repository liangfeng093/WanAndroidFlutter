import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/bean/Article.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/ContentPage.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/home/ArticleItemWidget.dart';
import 'package:wanandroidflutter/widget/knowledge/Knowledge.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/8/9
 * @Description:
 */
class KnowledgeAllPage extends StatefulWidget {
  List<Knowledge> knowledges;

  KnowledgeAllPage(this.knowledges);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KnowledgeAllPageState(knowledges);
  }
}

class KnowledgeAllPageState extends BaseView with TickerProviderStateMixin {
  TabController _tabController;

  var refreshController = RefreshController(initialRefresh: false);
  var scrollController = ScrollController();

  List<Knowledge> _knowledges;
  List<Article> _mArticles = List();

  KnowledgeAllPageState(this._knowledges);

  int currentPage = 0;
  String currentId = "60";
  int indicatorIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(
        initialIndex: indicatorIndex, length: _knowledges.length, vsync: this);
    super.initState();
  }

  @override
  void getData() {
    getKnowledgeArticles(currentPage, currentId, true);
  }

  getKnowledgeArticles(int page, String id, bool isClear) {
    App.dataRepository.getKnowledgeArticles(page, id).then((list) {
      LogUtils.e(TAG, "*********>>>>>>>>>>知识体系下的文章:" + list.toString());
      setState(() {
        if (list.length > 0) {
          if (isClear) {
            _mArticles.clear();
          }
          _mArticles.addAll(list);
          if (refreshController.isRefresh) {
            refreshController.refreshCompleted();
          }
          if (refreshController.isLoading) {
            refreshController.loadComplete();
          }
        } else {
          //没有加载到更多
          if (refreshController.isRefresh) {
            refreshController.resetNoData();
          }
          if (refreshController.isLoading) {
            refreshController.loadNoData();
          }
        }
        currentState = States.StateSuccess;
      });
    });
  }

  @override
  Widget initSuccessView() {
    var tabs = List<Widget>();
    for (var knowledge in _knowledges) {
      var tab = Container(
        height: 40,
        child: Center(
          child: Text(
            knowledge.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
      tabs.add(tab);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "文章列表",
          style: TextStyle(),
        ),
        bottom: TabBar(
          tabs: tabs,
          controller: _tabController,
          //默认不能滑动
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: App.primaryColor,
          onTap: (index) {
            currentPage = 0;
            currentId = _knowledges[index].id.toString();
            getKnowledgeArticles(currentPage, currentId, true);
          },
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(),
        onRefresh: () {
          LogUtils.e("SmartRefresher", "下拉刷新");
//                      getList(currentPubNumId, page, index, isJump);
          getKnowledgeArticles(0, currentId, true);
        },
        onLoading: () {
          LogUtils.e("SmartRefresher", "上拉加载");
          ++currentPage;
          getKnowledgeArticles(currentPage, currentId, false);
        },
        controller: refreshController,
        child: ListView.builder(
            itemCount: _mArticles.length,
            itemBuilder: (BuildContext context, int index) {
              var article = _mArticles[index];
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
            }),
      ),
    );
  }

  _onClickItem(int index) {
    var article = _mArticles[index];
    LogUtils.e(TAG, "title:" + article.title);
    LogUtils.e(TAG, "link:" + article.link);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ContentPage(article.link);
    }));
  }
}
