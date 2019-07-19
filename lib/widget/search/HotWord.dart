/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/19
 * @Description:
 */
class HotWord {
  int id;
  String link;
  String name;
  int order;
  int visible;

  HotWord({
    this.id,
    this.link,
    this.name,
    this.order,
    this.visible,
  });

  factory HotWord.fromJson(Map<String, dynamic> json) => new HotWord(
    id: json["id"],
    link: json["link"],
    name: json["name"],
    order: json["order"],
    visible: json["visible"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "name": name,
    "order": order,
    "visible": visible,
  };
}
