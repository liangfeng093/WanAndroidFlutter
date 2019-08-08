import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/projects/JumpEvent.dart';
import 'package:wanandroidflutter/widget/projects/Project.dart';

import 'ProjectType.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/31
 * @Description:项目页面
 */
class ProjectAllPage extends StatefulWidget {
  List<ProjectType> tabs;
  int indicatorIndex;

  ProjectAllPage(this.tabs, this.indicatorIndex);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectAllState(tabs, indicatorIndex);
  }
}

class ProjectAllState extends BaseView with TickerProviderStateMixin {
  List<Widget> childWidgets = List();
  List<Project> projects = List();

  List<ProjectType> _mTypes;
  int indicatorIndex;

  ProjectAllState(this._mTypes, this.indicatorIndex);

  TabController _tabController;

  var refreshController = RefreshController(initialRefresh: false);
  var scrollController = ScrollController();

  int currentPage = 1;
  String currentId = "294";

  @override
  void initState() {
    // TODO: implement initState
    /*App.eventBus.on<JumpEvent>().listen((event) {
      currentState = States.StateLoading;
      App.dataRepository.getProjects(1, event.id).then((list) {
        setState(() {
          LogUtils.e(TAG, "====>>>>>getProjects:" + list.toString());
          projects.clear();
          projects.addAll(list);
          currentState = States.StateSuccess;
        });
      });
    });*/
    currentId = _mTypes[indicatorIndex].id.toString();
    _tabController = TabController(
        initialIndex: indicatorIndex, length: _mTypes.length, vsync: this);
    super.initState();
  }

  @override
  void getData() {
    getProjects(1, currentId, false);
  }

  void getProjects(int page, String id, bool isClear) {
    App.dataRepository.getProjects(page, id).then((list) {
      setState(() {
        LogUtils.e(TAG, "====>>>>>getProjects:" + list.toString());
        if (list.length > 0) {
          if (isClear) {
            projects.clear();
          }
          projects.addAll(list);
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
    // TODO: implement initSuccessView
    var tabs = List<Widget>();
    for (var type in _mTypes) {
      var tab = Container(
        height: 40,
        child: Center(
          child: Text(
            type.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
      tabs.add(tab);
    }
    LogUtils.e(TAG,
        "====>>>>>initSuccessView====>>>tabs.length" + tabs.length.toString());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "项目列表",
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
            currentPage = 1;
            currentId = _mTypes[index].id.toString();
            getProjects(currentPage, currentId, true);
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
          getProjects(1, currentId, true);
        },
        onLoading: () {
          LogUtils.e("SmartRefresher", "上拉加载");
          ++currentPage;
          getProjects(currentPage, currentId, false);
        },
        controller: refreshController,
        child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (BuildContext context, int index) {
              return _item(index);
            }),
      ),
    );
  }

  Widget _item(int index) {
    LogUtils.e(TAG, "====>>>>>getProjects====>>>index" + index.toString());
    LogUtils.e(
        TAG, "====>>>>>getProjects====>>>length" + projects.length.toString());

    var project = projects[index];
    var picUrl = project.envelopePic;
    var title = project.title;
    var desc = project.desc;
    var time = DateTime.fromMillisecondsSinceEpoch(project.publishTime)
        .toString()
        .substring(0, 10);
    return Card(
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, //文本溢出使用省略号处理
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            desc,
                            style: TextStyle(fontSize: 13),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis, //文本溢出使用省略号处理
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Container(
                        height: 10,
                        child: Text(
                          time,
                          style: TextStyle(fontSize: 10),
                        ),
                        alignment: Alignment.bottomLeft,
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        picUrl,
                        height: 100,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
