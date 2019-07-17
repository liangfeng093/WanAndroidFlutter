import 'package:flutter/material.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';

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

class PublicNumberPageState extends State<PublicNumberPage>
    with SingleTickerProviderStateMixin {
  final String TAG = "PublicNumberPageState";

  List<Tab> _mTabs = [];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    App.dataRepository.getPubNumTab().then((list) {
      LogUtils.e(TAG, "size:" + list.length.toString());
      _mTabs.clear();
      list.forEach((item) {
        _mTabs.add(Tab(
          child: Text(
            item.name,
            style: TextStyle(color: Colors.black,fontSize: 15),
          ),
        ));
      });
      setState(() {
        _tabController = TabController(vsync: this, length: _mTabs.length);
      });
    });

    super.initState();
//    _tabController = TabController(vsync: this, length: _mTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_mTabs.length > 0) {
      return Column(
        children: <Widget>[
          TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: _mTabs,
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Text("this is PublicNumberPage"),
        ],
      );
    }
  }
}
