import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/knowledge/Knowledge.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/4
 * @Description:
 */
class KnowledgeItem extends StatefulWidget {
  List<Knowledge> childs;
  String title;

  KnowledgeItem(this.childs, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KnowledgeItemState(childs, title);
  }
}

class KnowledgeItemState extends State<KnowledgeItem> {
  final String TAG = "KnowledgeItemState";

  List<Knowledge> childs;
  String title;

  KnowledgeItemState(this.childs, this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> childWidgets = List();
    childs.forEach((item) {
      childWidgets.add(Padding(
        padding: EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () {
            LogUtils.e(TAG, "点击:" + item.name);
          },
          child: Chip(
            //随机颜色
            backgroundColor: Color.fromARGB(
              100,
              Random.secure().nextInt(255),
              Random.secure().nextInt(255),
              Random.secure().nextInt(255),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: Text(item.name),
          ),
        ),
      ));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Wrap(
          children: childWidgets,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Divider(
            height: 1,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
