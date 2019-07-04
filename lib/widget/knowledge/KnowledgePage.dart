import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
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

class KnowledgePageState extends State<KnowledgePage> {
  final String TAG = "KnowledgePageState";

  List<Knowledge> _list = List();

  @override
  void initState() {
    // TODO: implement initState
    App.dataRepository.getKnowledgeSystem().then((list) {
      LogUtils.e(TAG, "size:" + list.length.toString());
      setState(() {
        _list.clear();
        _list.addAll(list);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          var tilte = _list[index].name;
          var childs = _list[index].children;
          return KnowledgeItem(childs,tilte);
        });
  }
}
