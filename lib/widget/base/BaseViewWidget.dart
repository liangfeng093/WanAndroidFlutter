import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
   * 设置空视图
   */
//  void setEmptyView(Widget emptyView);
  void showEmptyView();

  /**
   * 设置加载中视图
   */
//  void setLoadingView(Widget loadingView);
  void showLoadingView();

  /**
   * 设置网络异常视图
   */
//  void setNetworkExceptionView(Widget exceptionView);
  void showNetworkExceptionView();
}

enum States {
  StateLoading,
  StateSuccess,
  StateException,
}

abstract class BaseView<BaseViewWidget> extends State implements IBaseView {
  /**
   * 默认加载中
   */
  States currentState = States.StateLoading;
  Widget emptyView = _initEmptyView();
  Widget loadingView = _initLoadingView();
  Widget exceptionView = _initExceptionView();

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  static Widget _initEmptyView() {
    return Container(
      child: Icon(Icons.filter_drama),
    );
  }

  static Widget _initLoadingView() {
    return Center(
      child: SizedBox(
        height: 80,
        width: 80,
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget _initExceptionView() {
    return Container(
      child: Icon(Icons.error_outline),
    );
  }
}
