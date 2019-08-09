import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/knowledge/Knowledge.dart';
import 'package:wanandroidflutter/widget/knowledge/KnowledgeAllPage.dart';
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
          var title = _list[index].name;
          var childs = _list[index].children;
          return GestureDetector(
            onTap: () => _onClickItem(index),
            child: KnowledgeItem(childs, title),
          );
        });
  }

  _onClickItem(int index) {
    LogUtils.e(TAG, "_onClickItem:" + _list[index].toString());
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return KnowledgeAllPage(_list[index].children);
    }));
  }
}
