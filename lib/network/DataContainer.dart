import 'dart:convert';

import 'package:wanandroidflutter/bean/Article.dart';

class DataContainer<T> {
  int errorCode;
  String errorMsg;
  T data;

  DataContainer(this.errorCode, this.errorMsg, this.data);

}

/**
 *
 */
class ArticleList {
  int curPage;
  List<Article> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ArticleList({
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  factory ArticleList.fromJson(json) =>
      new ArticleList(
        curPage: json["curPage"],
        datas: new List<Article>.from(
            json["datas"].map((x) => Article.fromJson(x))),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
      );

  @override
  String toString() {
    return 'ArticleList{curPage: $curPage, datas: $datas, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total}';
  }
}

/**
 * 首页文章
 */

class Tag {
  String name;
  String url;

  Tag({
    this.name,
    this.url,
  });

  factory Tag.fromJson(json) =>
      new Tag(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "url": url,
      };
}
