/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/8/1
 * @Description:
 */
class Project {
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

  Project({
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

  factory Project.fromJson(Map<String, dynamic> json) => new Project(
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
    "niceDate": "${niceDate.year.toString().padLeft(4, '0')}-${niceDate.month.toString().padLeft(2, '0')}-${niceDate.day.toString().padLeft(2, '0')}",
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
    return 'Project{apkLink: $apkLink, author: $author, chapterId: $chapterId, chapterName: $chapterName, collect: $collect, courseId: $courseId, desc: $desc, envelopePic: $envelopePic, fresh: $fresh, id: $id, link: $link, niceDate: $niceDate, origin: $origin, prefix: $prefix, projectLink: $projectLink, publishTime: $publishTime, superChapterId: $superChapterId, superChapterName: $superChapterName, tags: $tags, title: $title, type: $type, userId: $userId, visible: $visible, zan: $zan}';
  }


}

class ProjectsData{
  int size;
  List datas;

  ProjectsData.fromJson(Map<String, dynamic> json)
      : size = json['size'],
        datas = json['datas'];
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

  @override
  String toString() {
    return 'Tag{name: $name, url: $url}';
  }


}