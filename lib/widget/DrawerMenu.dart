import 'package:flutter/material.dart';
import 'package:wanandroidflutter/widget/dialog/ThemSelectDialog.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/31
 * @Description:侧滑菜单的目录视图
 */
class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text("收藏"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.apps),
          title: Text("主题"),
          onTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ThemSelectDialog();
                });
          },
        ),
        ListTile(
          leading: Icon(Icons.all_inclusive),
          title: Text("常用网站"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("设置"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text("分享"),
          onTap: () {},
        ),
      ],
    );
  }
}
