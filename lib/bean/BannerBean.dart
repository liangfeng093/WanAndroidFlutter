/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/19
 * @Description:
 */

import 'dart:convert';

BannerBean bannerFromJson(String str) => BannerBean.fromJson(json.decode(str));

String bannerToJson(BannerBean data) => json.encode(data.toJson());

class BannerBean {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerBean({
    this.desc,
    this.id,
    this.imagePath,
    this.isVisible,
    this.order,
    this.title,
    this.type,
    this.url,
  });

  ///解析map，初始化成员变量
  factory BannerBean.fromJson(Map<String, dynamic> json) => new BannerBean(
    desc: json["desc"],
    id: json["id"],
    imagePath: json["imagePath"],
    isVisible: json["isVisible"],
    order: json["order"],
    title: json["title"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "id": id,
    "imagePath": imagePath,
    "isVisible": isVisible,
    "order": order,
    "title": title,
    "type": type,
    "url": url,
  };
}