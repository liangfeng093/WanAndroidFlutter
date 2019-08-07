import 'package:wanandroidflutter/RemoteApi.dart';
import 'package:wanandroidflutter/bean/Article.dart';
import 'package:wanandroidflutter/bean/BannerBean.dart';
import 'package:wanandroidflutter/bean/FriendUrl.dart';
import 'package:wanandroidflutter/widget/projects/Project.dart';
import 'package:wanandroidflutter/widget/projects/ProjectType.dart';
import 'package:wanandroidflutter/widget/search/HotWord.dart';
import 'package:wanandroidflutter/network/DataContainer.dart';
import 'package:wanandroidflutter/network/apis.dart';
import 'package:wanandroidflutter/widget/knowledge/Knowledge.dart';
import 'package:wanandroidflutter/widget/pub_num/WxArticle.dart';

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
                path: WanAndroidApi.ARTICLE_LIST, page: page));

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

  /**
   * 知识体系
   *
   */
  Future<List<Knowledge>> getKnowledgeSystem() async {
    DataContainer<List> dataContainer = await RemoteApi.getInstance().request(
        RemoteApi.GET, WanAndroidApi.splicePath(path: WanAndroidApi.TREE));
    List<Knowledge> list;
    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }
    //判断数据集
    if (dataContainer.data != null) {
      list = dataContainer.data.map((item) {
        return Knowledge.fromJson(item);
      }).toList();
    }
    return list;
  }

  /**
   * 知识体系下的文章
   */
  getKnowledgeArticles() {}

  /**
   * 获取公众号tab
   */
  Future<List<Knowledge>> getPubNumTab() async {
    DataContainer<List> dataContainer = await RemoteApi.getInstance()
        .request<List>(RemoteApi.GET,
            WanAndroidApi.splicePath(path: WanAndroidApi.WXARTICLE_CHAPTERS));
    List<Knowledge> list;
    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }
    //判断数据集
    if (dataContainer.data != null) {
      list = dataContainer.data.map((item) {
        return Knowledge.fromJson(item);
      }).toList();
    }
    return list;
  }

  /**
   * 查看某个公众号历史数据
   */
  Future<List<WxArticle>> getPubNumHistory(String pubNumId, String page) async {
    String parameter = pubNumId + "/" + page;
    DataContainer<Map<String, dynamic>> dataContainer =
        await RemoteApi.getInstance().request(
            RemoteApi.GET,
            WanAndroidApi.splicePath(
                path: WanAndroidApi.WXARTICLE_LIST, parameter: parameter));
    List<WxArticle> list;
    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }
    //判断数据集
    if (dataContainer.data != null) {
      WxArticleList wxArticleList = WxArticleList.fromJson(dataContainer.data);
      list = wxArticleList.datas.map((item) {
        return WxArticle.fromJson(item.toJson());
      }).toList();
    }
    return list;
  }

  /**
   * 常用网站
   */
  Future<List<FriendUrl>> getFriendUrl() async {
    DataContainer<List> dataContainer = await RemoteApi.getInstance()
        .request<List>(RemoteApi.GET,
            WanAndroidApi.splicePath(path: WanAndroidApi.FRIEND_URL_LIST));
    List<FriendUrl> list;
    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }
    //判断数据集
    if (dataContainer.data != null) {
      list = dataContainer.data.map((item) {
        return FriendUrl.fromJson(item);
      }).toList();
    }
    return list;
  }

  /**
   * 搜索热词
   */
  Future<List<HotWord>> getHotWord() async {
    DataContainer<List> dataContainer = await RemoteApi.getInstance()
        .request<List>(RemoteApi.GET,
            WanAndroidApi.splicePath(path: WanAndroidApi.HOT_KEY));
    List<HotWord> list;
    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }
    //判断数据集
    if (dataContainer.data != null) {
      list = dataContainer.data.map((item) {
        return HotWord.fromJson(item);
      }).toList();
    }
    return list;
  }

  /**
   * 项目分类
   */
  Future<List<ProjectType>> getProjectTypes() async {
    DataContainer<List> dataContainer = await RemoteApi.getInstance()
        .request<List>(RemoteApi.GET,
            WanAndroidApi.splicePath(path: WanAndroidApi.PROJECT_TREE));
    List<ProjectType> list;
    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }
    //判断数据集
    if (dataContainer.data != null) {
      list = dataContainer.data.map((item) {
        return ProjectType.fromJson(item);
      }).toList();
    }
    return list;
  }

  /**
   * 项目列表数据
   */

  Future<List<Project>> getProjects(int page,String id ) async {
    DataContainer<Map<String, dynamic>> dataContainer =
    await RemoteApi.getInstance().request<Map<String, dynamic>>(
        RemoteApi.GET,
        WanAndroidApi.splicePath(
            path: WanAndroidApi.PROJECT_LIST, page: page,id: id));

    List<Project> projects;

    //请求错误,返回error
    if (dataContainer.errorCode != ResultCode.SUCCESS) {
      return Future.error(dataContainer.errorMsg);
    }

    //判断数据集
    if (dataContainer.data != null) {
      //dataContainer.data的类型:List<Map<String,String>>
      //map方法遍历list====>dataContainer.data,list中的每个元素作为参数执行传入的函数
      //map方法执行(遍历)完后返回MappedIterable
      ProjectsData projectsData = ProjectsData.fromJson(dataContainer.data);
      projects = projectsData.datas.map((item) {
        return Project.fromJson(item);
      }).toList();
      /*articles = dataContainer.data.map((item) {
        ///解析map，初始化成员变量。
        return Article.fromJson(item);
      }).toList(); //MappedIterable转化为List*/
    }
    return projects;
  }
}
