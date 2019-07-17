import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/knowledge/Knowledge.dart';
import 'package:wanandroidflutter/widget/knowledge/KnowledgeItem.dart';

import '../../main.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/3
 * @Description:知识体系
 */
class KnowledgePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KnowledgePageState();
  }
}

//class KnowledgePageState extends State<KnowledgePage> {
class KnowledgePageState extends BaseView {
  final String TAG = "KnowledgePageState";

  List<Knowledge> _list = List();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  void getData() {
    // TODO: implement getData
    App.dataRepository.getKnowledgeSystem().then((list) {
      LogUtils.e(TAG, "size:" + list.length.toString());
      setState(() {
        _list.clear();
        _list.addAll(list);
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
    return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          var tilte = _list[index].name;
          var childs = _list[index].children;
          return KnowledgeItem(childs, tilte);
        });
  }
}
