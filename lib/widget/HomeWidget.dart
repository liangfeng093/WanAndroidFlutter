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
              if (index == 0) {
                return Container(
                  height: 200,
                  child: BannerWidget(),
                );
              }
              if (mArticles.length > 0) {
                var article = mArticles[index];
                var time =
                    DateTime.fromMillisecondsSinceEpoch(article.publishTime);
                return Container(
//                  height: 60,
                    //此处的padding实际上做出来margin的效果
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: ArticleItemWidget(article.title, article.author,
                        time.toString().substring(0, 10)));
              } else {
                return Container(
                  height: 50,
                  child: Center(child: Text("未获取到数据")),
                );
              }
            }));
  }
}

class ArticleItemWidget extends StatefulWidget {
  String title;
  String author;
  String time;

  ArticleItemWidget(this.title, this.author, this.time);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticleItemState(title, author, time);
  }
}

class ArticleItemState extends State {
  String title;
  String author;
  String time;

  ArticleItemState(this.title, this.author, this.time);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Card(
        child: Column(
      children: <Widget>[
        Align(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 0, 4),
            child: Text(
              author,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        Align(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 4),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        Align(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 4),
            child: Text(time),
          ),
          alignment: Alignment.bottomRight,
        ),
      ],
    ));
  }
}
