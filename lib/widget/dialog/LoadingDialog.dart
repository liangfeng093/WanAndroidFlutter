import 'package:flutter/material.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/30
 * @Description:
 */
class LoadingDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //创建透明层
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Center(
        //设置控件大小
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          //填充容器，配置形状
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: CircularProgressIndicator(),
            ),
            /*child: Column(
              children: <Widget>[CircularProgressIndicator()],
            ),*/
          ),
        ),
      ),
    );
  }
}
