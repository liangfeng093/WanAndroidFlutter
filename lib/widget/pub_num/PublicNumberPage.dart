import 'package:flutter/material.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';

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

class PublicNumberPageState extends BaseView
    with SingleTickerProviderStateMixin {
  final String TAG = "PublicNumberPageState";

  List<Tab> _mTabs = [];
  TabController _tabController;

  @override
  void getData() {
    App.dataRepository.getPubNumTab().then((list) {
      LogUtils.e(TAG, "size:" + list.length.toString());
      _mTabs.clear();
      list.forEach((item) {
        _mTabs.add(Tab(
          child: Text(
            item.name,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ));
      });
      setState(() {
        _tabController = TabController(vsync: this, length: _mTabs.length);
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
    return Column(
      children: <Widget>[
        TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: _mTabs,
        ),
      ],
    );
  }
}
