/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/31
 * @Description:
 */
class ProjectType {
  List<dynamic> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  ProjectType({
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  });

  factory ProjectType.fromJson(Map<String, dynamic> json) => new ProjectType(
    children: new List<dynamic>.from(json["children"].map((x) => x)),
    courseId: json["courseId"],
    id: json["id"],
    name: json["name"],
    order: json["order"],
    parentChapterId: json["parentChapterId"],
    userControlSetTop: json["userControlSetTop"],
    visible: json["visible"],
  );

  Map<String, dynamic> toJson() => {
    "children": new List<dynamic>.from(children.map((x) => x)),
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
    return 'ProjectType{children: $children, courseId: $courseId, id: $id, name: $name, order: $order, parentChapterId: $parentChapterId, userControlSetTop: $userControlSetTop, visible: $visible}';
  }


}

