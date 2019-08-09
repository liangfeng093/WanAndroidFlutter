/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/4
 * @Description:
 */
class Knowledge {
  List<Knowledge> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  Knowledge({
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  });

  factory Knowledge.fromJson(Map<String, dynamic> json) => new Knowledge(
        children: new List<Knowledge>.from(
            json["children"].map((x) => Knowledge.fromJson(x))),
        courseId: json["courseId"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        parentChapterId: json["parentChapterId"],
        userControlSetTop: json["userControlSetTop"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "children": new List<dynamic>.from(children.map((x) => x.toJson())),
        "courseId": courseId,
        "id": id,
        "name": name,
        "order": order,
        "parentChapterId": parentChapterId,
        "userControlSetTop": userControlSetTop,
        "visible": visible,
      };

  @override
  String toString() {
    return 'Knowledge{children: $children, courseId: $courseId, id: $id, name: $name, order: $order, parentChapterId: $parentChapterId, userControlSetTop: $userControlSetTop, visible: $visible}';
  }


}
