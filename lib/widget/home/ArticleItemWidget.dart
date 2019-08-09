import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/27
 * @Description:
 */
class ArticleItemWidget extends StatelessWidget {
  String title;
  String author;
  String time;

  ArticleItemWidget(this.title, this.author, this.time);


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
