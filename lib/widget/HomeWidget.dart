import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/bean/Article.dart';
import 'package:wanandroidflutter/network/DataRepository.dart';
import 'package:wanandroidflutter/widget/BannerWidget.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/26
 * @Description:
 */

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeStatus();
  }
}

class HomeStatus extends State {
  List<Article> mArticles = List();

  _initArticleData() {
    DataRepository repository = DataRepository();
    //then方法:注册一个Future回调
    //当getBanner返回Future时出发then回调
    repository.getArticles(0).then((articles) {
      articles.forEach((item) {
        mArticles.add(item);
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _initArticleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: Drawer(
          child: Text("777"),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "首页",
            style: TextStyle(),
          ),
        ),
        body: ListView.builder(
            itemCount: mArticles.length,
            itemBuilder: (BuildContext context, int index) {
              if (mArticles.length > 0) {
                return Container(
                  height: 50,
                  child: Center(child: Text(mArticles[index].title)),
                );
              } else {
                return Container(
                  height: 50,
                  child: Center(child: Text("未获取到数据")),
                );
              }
            })
        /*body: Column(
          children: <Widget>[
            Container(
              child: BannerWidget(),
              height: 200,
            ),
            ListView.builder(itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
//                color: Colors.amber[colorCodes[index]],
//                child: Center(child: Text('Entry ${entries[index]}')),
                child: Center(child: Text(mArticles[index].title)),
              );
            })
          ],
        )*/
        );
  }
}
