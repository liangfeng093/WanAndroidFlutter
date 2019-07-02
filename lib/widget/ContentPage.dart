import 'package:flutter/material.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/2
 * @Description:
 */
class ContentPage extends StatefulWidget {
  String _url;

  ContentPage(this._url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentPageState(_url);
  }
}

class ContentPageState extends State<ContentPage> {
  String _url;
  bool isLoad = true;

  ContentPageState(this._url);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var webView = WebView();

//    ScrollView
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "内容页",
          style: TextStyle(),
        ),
        bottom: PreferredSize(
          child: isLoad ? new LinearProgressIndicator() : new Divider(height: 0,),
        ),
      ),
//      body: Text("this is ContentPage"),

      body: WebView(
        onWebViewCreated: (WebViewController controller) {
          controller;
        },
//        gestureRecognizers: ,
        //webview支持js
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: _url,
        onPageFinished: (str) {
          LogUtils.e("onPageFinished=====>", "str:" + str);
          setState(() {
            //加载完毕
            isLoad = false;
          });
        },
      ),
    );
  }
}
