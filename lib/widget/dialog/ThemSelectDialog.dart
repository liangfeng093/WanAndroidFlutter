import 'package:flutter/material.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/widget/home/Events.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/30
 * @Description:
 */
class ThemSelectDialog extends Dialog {
  var colors = [
    Colors.yellow,
    Colors.blue,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
    Colors.green,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.tealAccent,
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //创建透明层
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Center(
        //设置控件大小
        child: SizedBox(
          width: 350.0,
          height: 250.0,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 350.0,
                  child: Center(
                      child: Text(
                    "设置主题",
                    style: TextStyle(fontSize: 20),
                  )),
                  color: Colors.white,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  child: GridView.builder(
                      itemCount: colors.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, //横轴元素个数
                        //纵轴间距
                        mainAxisSpacing: 5.0,
                        //横轴间距
                        crossAxisSpacing: 5.0,
                        //子组件宽高长度比例
                        /*childAspectRatio: 1.0*/
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            App.eventBus.fire(ThemEvent(colors[index]));
                          },
                          child: Container(
                            color: colors[index],
                          ),
                        );
                      }),
                ),
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
