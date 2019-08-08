import 'package:flutter/material.dart';
import 'package:wanandroidflutter/main.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:wanandroidflutter/widget/base/BaseViewWidget.dart';
import 'package:wanandroidflutter/widget/projects/JumpEvent.dart';
import 'package:wanandroidflutter/widget/projects/ProjectType.dart';

import 'ProjectAllPage.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/8/1
 * @Description:项目分类
 */
class ProjectTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectTypeState();
  }
}

class ProjectTypeState extends BaseView {
  final String TAG = "ProjectTypePage";

  var colors = [
    Colors.blue,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
    Colors.green,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  List<ProjectType> types = List();

  @override
  void getData() {
    // TODO: implement getData
    App.dataRepository.getProjectTypes().then((list) {
      LogUtils.e(
          TAG,
          "<<<<<<<<<<<=====>>>>>>>>getProjectTypes.size" +
              list.length.toString());
      LogUtils.e(
          TAG, "<<<<<<<<<<<=====>>>>>>>>getProjectTypes:" + list.toString());

      setState(() {
        types.clear();
        types.addAll(list);
        currentState = States.StateSuccess;
      });
    });
  }

  @override
  Widget initSuccessView() {
    // TODO: implement initSuccessView
    return Container(
      color: Colors.white70,
      child: GridView.builder(
          padding: EdgeInsets.all(20),
          itemCount: types.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //横轴元素个数
            //纵轴间距
            mainAxisSpacing: 20.0,
            //横轴间距
            crossAxisSpacing: 20.0,
            //子组件宽高长度比例
            /*childAspectRatio: 1.0*/
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
//                App.eventBus.fire(JumpEvent(types[index].id.toString()));
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ProjectAllPage(types,index);
                }));
              },
              child: Container(
                color: colors[index % 7],
                child: _item(index),
              ),
            );
          }),
    );
  }

  Widget _item(int index) {
    return Center(
        child: Text(
      types[index].name,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ));
  }
}
