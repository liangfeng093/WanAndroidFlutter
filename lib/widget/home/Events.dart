/**
 * @Author: mzf
 * @emil: liangfeng093@gmail.com
 * @Date: 2019/7/2
 * @Description:
 */
class ScrollToTopEvent {
  static final HOME = "EVENT_TYPE_HOME";

//  static final HOME = "ScrollToTopEvent_HOME";
//  static final HOME = "ScrollToTopEvent_HOME";

  String eventType;

  ScrollToTopEvent(this.eventType);
}

class ShowHomeFABEvent {
  var isShow = false;

  ShowHomeFABEvent(this.isShow);
}
