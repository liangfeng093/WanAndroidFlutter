import 'dart:convert';

class DataContainer<T> {
  int errorCode;
  String errorMsg;
  T data;

  /**
   *
   */
  factory DataContainer(jsonStr, Function buildFun) => jsonStr is String
      ? DataContainer.fromJson(json.decode(jsonStr), buildFun)
      : DataContainer.fromJson(jsonStr, buildFun);

  /**
   *
   */
  DataContainer.fromJson(jsonRes, Function buildFun) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    //
    data = buildFun(jsonRes['data']);
  }
}

/**
 *
 */
class ArticleList {
  int curPage;
  List<Article> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ArticleList({
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  factory ArticleList.fromJson(json) => new ArticleList(
        curPage: json["curPage"],
        datas: new List<Article>.from(
            json["datas"].map((x) => Article.fromJson(x))),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
      );

  @override
  String toString() {
    return 'ArticleList{curPage: $curPage, datas: $datas, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total}';
  }


}

/**
 * 首页文章
 */
class Article {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String prefix;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<String> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  Article({
    this.apkLink,
    this.author,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.envelopePic,
    this.fresh,
    this.id,
    this.link,
    this.niceDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  factory Article.fromJson(json) => new Article(
        apkLink: json["apkLink"],
        author: json["author"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        collect: json["collect"],
        courseId: json["courseId"],
//    desc: descValues.map[json["desc"]],
        desc: json["desc"],
        envelopePic: json["envelopePic"],
        fresh: json["fresh"],
        id: json["id"],
        link: json["link"],
        niceDate: json["niceDate"],
        origin: json["origin"],
        prefix: json["prefix"],
        projectLink: json["projectLink"],
        publishTime: json["publishTime"],
        superChapterId: json["superChapterId"],
        superChapterName: json["superChapterName"],
//    datas: new List<Article>.from(json["datas"].map((x) => Article.fromJson(x))),
//        tags: new List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        title: json["title"],
        type: json["type"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
      );

  @override
  String toString() {
    return 'Article{apkLink: $apkLink, author: $author, chapterId: $chapterId, chapterName: $chapterName, collect: $collect, courseId: $courseId, desc: $desc, envelopePic: $envelopePic, fresh: $fresh, id: $id, link: $link, niceDate: $niceDate, origin: $origin, prefix: $prefix, projectLink: $projectLink, publishTime: $publishTime, superChapterId: $superChapterId, superChapterName: $superChapterName, tags: $tags, title: $title, type: $type, userId: $userId, visible: $visible, zan: $zan}';
  }


}

class Tag {
  String name;
  String url;

  Tag({
    this.name,
    this.url,
  });

  factory Tag.fromJson(json) => new Tag(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
