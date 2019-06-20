import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:wanandroidflutter/bean/BannerBean.dart';
import 'package:wanandroidflutter/network/DataRepository.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/19
 * @Description:轮播图控件
 */
class BannerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BannerState();
  }
}

class BannerState extends State<BannerWidget> {
  List<BannerBean> banners = List();

  void _loadBannerData() {
    DataRepository repository = DataRepository();
    //then方法:注册一个Future回调
    //当getBanner返回Future时出发then回调
    repository.getBanner().then((bannerList) {
      banners.clear();
      banners.addAll(bannerList);
      //修改widget状态(填充数据)
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadBannerData(); //在State的Widget进行初始化的时候，就进行加载数据
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView(
      scrollDirection: Axis.horizontal,
      children: _bannerItem(),
    );
    /* return PageView(
      children: <Widget>[
        Image.network(
            "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png"),
        Image.network(
            "https://www.wanandroid.com/blogimgs/ab17e8f9-6b79-450b-8079-0f2287eb6f0f.png"),
        Image.network(
            "https://www.wanandroid.com/blogimgs/fb0ea461-e00a-482b-814f-4faca5761427.png"),
      ],
    );*/
  }

  _bannerItem() {
    List<Widget> items = [];
    banners.forEach((banner) {
      items.add(Image.network(banner.imagePath,fit: BoxFit.fill,));
    });
    return items;
  }
}

class BannerItemWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
