import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/17
 * @Description:封装基类
 */
abstract class IBaseView {
  /**
   * 获取数据
   */
  void getData();

  /**
   * 初始化内容视图
   */
  Widget initSuccessView();
}

enum States {
  StateLoading,
  StateSuccess,
  StateException,
}

abstract class BaseView<BaseViewWidget> extends State implements IBaseView {
  final String TAG = "BaseView";

  /**
   * 默认加载中
   */
  States currentState = States.StateLoading;
  Widget emptyView;
  Widget loadingView;
  Widget exceptionView;

  @override
  void initState() {
    // TODO: implement initState
    emptyView = _initEmptyView();
    loadingView = _initLoadingView();
    exceptionView = _initExceptionView();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (currentState == States.StateLoading) {
      return loadingView;
    }
    if (currentState == States.StateException) {
      return exceptionView;
    }
    if (currentState == States.StateSuccess) {
      return initSuccessView();
    }
  }

  Widget _initEmptyView() {
    return Container(
      child: Icon(Icons.filter_drama),
    );
  }

  Widget _initLoadingView() {
    return Center(
        child: SizedBox(
      height: 80,
      width: 80,
      child: CircularProgressIndicator(),
    ));
  }

  Widget _initExceptionView() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentState = States.StateLoading;
            getData();
          });
        },
        child: SizedBox(
          height: 150,
          width: 150,
          child: Image.asset("assets/network_exception_.png"),
        ),
      ),
    );
  }
}
