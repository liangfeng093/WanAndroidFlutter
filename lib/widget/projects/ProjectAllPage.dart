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

  ProjectAllPage(this.tabs);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectAllState(tabs);
  }
}

class ProjectAllState extends BaseView with TickerProviderStateMixin {
  List<Widget> childWidgets = List();
  List<Project> projects = List();

  List<ProjectType> _mTypes;

  ProjectAllState(this._mTypes);

  TabController _tabController;



  @override
  void initState() {
    // TODO: implement initState
    App.eventBus.on<JumpEvent>().listen((event) {
      currentState = States.StateLoading;
      App.dataRepository.getProjects(1, event.id).then((list) {
        setState(() {
          LogUtils.e(TAG, "====>>>>>getProjects:" + list.toString());
          projects.clear();
          projects.addAll(list);
          currentState = States.StateSuccess;
        });
      });
    });

    _tabController =
        TabController(initialIndex: 0, length: _mTypes.length, vsync: this);
//        TabController(initialIndex: 0, length: 3, vsync: this);

//    currentState = States.StateSuccess;

    super.initState();
  }

  @override
  void getData() {
    getProjects(1, "294");
  }

  void getProjects(int page, String id) {
    App.dataRepository.getProjects(page, id).then((list) {
      setState(() {
        LogUtils.e(TAG, "====>>>>>getProjects:" + list.toString());
        projects.clear();
        projects.addAll(list);
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
            getProjects(1, _mTypes[index].id.toString());
          },
        ),
      ),
      body: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          }),
    );
    /* return Container(
      color: Colors.white70,
      child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          }),
    );*/
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
