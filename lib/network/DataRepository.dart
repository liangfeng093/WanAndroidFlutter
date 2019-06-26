import 'package:wanandroidflutter/RemoteApi.dart';
import 'package:wanandroidflutter/bean/Article.dart';
import 'package:wanandroidflutter/bean/BannerBean.dart';
import 'package:wanandroidflutter/network/DataContainer.dart';
import 'package:wanandroidflutter/network/apis.dart';

/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/19
 * @Description:数据仓库
 */
class DataRepository {
  final String Tag = "DataRepository";

  /**
   * 获取banner数据
   */
  Future<List<BannerBean>> getBanner() async {
    DataContainer<List> dataContainer = await RemoteApi.getInstance()
        .request<List>(
            RemoteApi.GET,
            WanAndroidApi.splicePath(
                path: WanAndroidApi.BANNER)); //参数path使用默认值WanAndroidApi.BANNER

    List<BannerBean> banners;
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
        return BannerBean.fromJson(item);
      }).toList(); //MappedIterable转化为List
    }
    return banners;
  }

  /**
   * 首页文章列表
   */

  Future<List<Article>> getArticles(int page) async {
    DataContainer<Map<String, dynamic>> dataContainer =
        await RemoteApi.getInstance().request<Map<String, dynamic>>(
            RemoteApi.GET,
            WanAndroidApi.splicePath(
                path: WanAndroidApi.ARTICLE_LIST, page: 0));

    List<Article> articles;

    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }

    //判断数据集
    if (dataContainer.data != null) {
      //dataContainer.data的类型:List<Map<String,String>>
      //map方法遍历list====>dataContainer.data,list中的每个元素作为参数执行传入的函数
      //map方法执行(遍历)完后返回MappedIterable
      ArticlesData articlesData = ArticlesData.fromJson(dataContainer.data);
      articles = articlesData.datas.map((item) {
        return Article.fromJson(item);
      }).toList();
      /*articles = dataContainer.data.map((item) {
        ///解析map，初始化成员变量。
        return Article.fromJson(item);
      }).toList(); //MappedIterable转化为List*/
    }
    return articles;
  }
}
