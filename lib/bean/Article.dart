/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/6/26
 * @Description:首页文章
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

class ArticlesData{
  int size;
  List datas;

  ArticlesData.fromJson(Map<String, dynamic> json)
      : size = json['size'],
        datas = json['datas'];
}