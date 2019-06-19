import 'package:wanandroidflutter/RemoteApi.dart';
import 'package:wanandroidflutter/bean/Banner.dart';
import 'package:wanandroidflutter/network/DataContainer.dart';
import 'package:wanandroidflutter/network/apis.dart';
import 'package:wanandroidflutter/utils/LogUtils.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/19
 * @Description:数据仓库
 */
class DataRepository {
  final String Tag = "DataRepository";

  Future<List<Banner>> getBanner() async {
    DataContainer<List> dataContainer = await RemoteApi.getInstance()
        .request<List>(
            RemoteApi.GET,
            WanAndroidApi.splicePath(
                path: WanAndroidApi.BANNER)); //参数path使用默认值WanAndroidApi.BANNER

    List<Banner> banners;
    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }

    //判断数据集
    if (dataContainer.data != null) {
      //dataContainer.data的类型:List<Map<String,String>>
      //map方法遍历list====>dataContainer.data,list中的每个元素作为参数执行传入的函数
      //map方法执行(遍历)完后返回MappedIterable
      banners = dataContainer.data.map((item) {
        ///解析map，初始化成员变量。
        return Banner.fromJson(item);
      }).toList(); //MappedIterable转化为List
    }
    return banners;
  }
}
