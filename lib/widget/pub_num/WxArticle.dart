/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/18
 * @Description:
 */
class WxArticleList {
  int curPage;
  List<WxArticle> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  WxArticleList({
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  factory WxArticleList.fromJson(Map<String, dynamic> json) =>
      new WxArticleList(
        curPage: json["curPage"],
        datas: new List<WxArticle>.from(
            json["datas"].map((x) => WxArticle.fromJson(x))),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "curPage": curPage,
        "datas": new List<dynamic>.from(datas.map((x) => x.toJson())),
        "offset": offset,
        "over": over,
        "pageCount": pageCount,
        "size": size,
        "total": total,
      };
}

class WxArticle {
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
  DateTime niceDate;
  String origin;
  String prefix;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  WxArticle({
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

  factory WxArticle.fromJson(Map<String, dynamic> json) => new WxArticle(
        apkLink: json["apkLink"],
        author: json["author"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        collect: json["collect"],
        courseId: json["courseId"],
        desc: json["desc"],
        envelopePic: json["envelopePic"],
        fresh: json["fresh"],
        id: json["id"],
        link: json["link"],
        niceDate: DateTime.parse(json["niceDate"]),
        origin: json["origin"],
        prefix: json["prefix"],
        projectLink: json["projectLink"],
        publishTime: json["publishTime"],
        superChapterId: json["superChapterId"],
        superChapterName: json["superChapterName"],
        tags: new List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        title: json["title"],
        type: json["type"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
      );

  Map<String, dynamic> toJson() => {
        "apkLink": apkLink,
        "author": author,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "collect": collect,
        "courseId": courseId,
        "desc": desc,
        "envelopePic": envelopePic,
        "fresh": fresh,
        "id": id,
        "link": link,
        "niceDate":
            "${niceDate.year.toString().padLeft(4, '0')}-${niceDate.month.toString().padLeft(2, '0')}-${niceDate.day.toString().padLeft(2, '0')}",
        "origin": origin,
        "prefix": prefix,
        "projectLink": projectLink,
        "publishTime": publishTime,
        "superChapterId": superChapterId,
        "superChapterName": superChapterName,
        "tags": new List<dynamic>.from(tags.map((x) => x.toJson())),
        "title": title,
        "type": type,
        "userId": userId,
        "visible": visible,
        "zan": zan,
      };

  @override
  String toString() {
    return 'WxArticle{apkLink: $apkLink, author: $author, chapterId: $chapterId, chapterName: $chapterName, collect: $collect, courseId: $courseId, desc: $desc, envelopePic: $envelopePic, fresh: $fresh, id: $id, link: $link, niceDate: $niceDate, origin: $origin, prefix: $prefix, projectLink: $projectLink, publishTime: $publishTime, superChapterId: $superChapterId, superChapterName: $superChapterName, tags: $tags, title: $title, type: $type, userId: $userId, visible: $visible, zan: $zan}';
  }


}

class Tag {
  String name;
  String url;

  Tag({
    this.name,
    this.url,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => new Tag(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
