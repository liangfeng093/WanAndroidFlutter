/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/19
 * @Description:
 */
class FriendUrl {
  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  FriendUrl({
    this.icon,
    this.id,
    this.link,
    this.name,
    this.order,
    this.visible,
  });

  factory FriendUrl.fromJson(Map<String, dynamic> json) => new FriendUrl(
    icon: json["icon"],
    id: json["id"],
    link: json["link"],
    name: json["name"],
    order: json["order"],
    visible: json["visible"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "id": id,
    "link": link,
    "name": name,
    "order": order,
    "visible": visible,
  };
}
