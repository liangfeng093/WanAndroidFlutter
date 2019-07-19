import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/search/HotWord.dart';
import 'package:wanandroidflutter/widget/search/HotWordItem.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/19
 * @Description:
 */
class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchPageState();
  }
}

class SearchPageState extends BaseView {
  List<HotWord> _hotWords = List();

  @override
  void initState() {
    // TODO: implement initState
    currentState = States.StateSuccess;
    super.initState();
  }

  @override
  void getData() {
    // TODO: implement getData
    App.dataRepository.getHotWord().then((list) {
      setState(() {
        _hotWords.clear();
        _hotWords.addAll(list);
      });
    });
  }

  @override
  Widget initSuccessView() {
    // TODO: implement initSuccessView
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
//              icon: Icon(Icons.search),
              hintText: "请输入关键字",
              hintStyle: TextStyle(color: Colors.white)),
          cursorColor: Colors.white,
          onTap: () {},
        ),
        actions: <Widget>[IconButton(icon: Text("搜索"), onPressed: () {})],
      ),
      body: Column(
        children: <Widget>[HotWordItem(_hotWords, "搜索热词")],
      ),
    );
  }
}
