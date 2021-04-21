import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// `@status`: 1. 正常； 2.失败； 3. 删除； 99. 完成
const Map<String, int> statusList = {
  'running': 1,
  'fail': 2,
  'invalid': 3,
  'end': 99,
};

class TargetListStates with ChangeNotifier, DiagnosticableTreeMixin {
  List<Target> _taskList = [
    Target(0, '早起', 3),
    Target(1, '锻炼', 30),
    Target(2, '背单词qwewqwqweqqweeqwqweew', 28),
  ];
  // {
  //   'id': 0,
  //   'title': '早起',
  //   'days': 30,
  //   'finish': 5,
  //   'status': 1,
  //   'lastFinish': '2020-04-18 15:59:21',
  // },
  // {
  //   'id': '1',
  //   'title': '早起',
  //   'days': '30',
  //   'finish': '15',
  //   'status': '1',
  //   'lastFinish': '2020-04-18 15:59:21',
  // },
  // {
  //   'id': '2',
  //   'title': '早起',
  //   'days': '30',
  //   'finish': '25',
  //   'status': '1',
  //   'lastFinish': '2020-04-18 15:59:21',
  // }

  List<Target> get taskList => _taskList;

  /// 修改`target`
  void modify(int id, String title, int days) {}

  /// 创建；并添加入 `_taskList` 列表
  void create(String title, int days) {
    var valid = getValidTarget().length;
    if (valid < 3) {
      var lastId = _taskList[_taskList.length - 1].id;
      _taskList.add(Target(lastId + 1, title, days));
      notifyListeners();
    } else {
      // TODO: 提醒超额
    }
  }

  /// 签到
  void sign(Target target) {
    target.sign();
    notifyListeners();
  }

  /// 删除
  void delete(Target target) {
    target.delete();
    notifyListeners();
  }

  /// 获取有效任务
  List<Target> getValidTarget() {
    return taskList
        .where((element) => element.status == statusList['running'])
        .toList();
  }

  /// 每次启动时自检，并且启动定时器：第二天3点时再次自检(重置所有finish)
  void checkLoop() {}

  /// Makes `Target` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('taskList', taskList));
  }
}

class Target {
  int id;
  String title;
  int days;
  int finish;
  bool finishToday;
  DateTime startTime;

  int status;
  DateTime lastFinish;

  Target(this.id, this.title, this.days,
      {this.finish = 0, this.status = 1, this.finishToday = false})
      : startTime = DateTime.now();

  void sign() {
    this.finish += 1;
    this.finishToday = true;
    this.lastFinish = DateTime.now();

    this.checkValid();
  }

  void delete() {
    this.status = statusList['delete'];
  }

  /// 每次启动时自检：重置所有finishToday；
  /// 启动定时器：第二天3点时再次自检
  void checkSelf() {}

  //任务是否有效；是否已经达成
  bool checkValid() {
    if (this.finish >= this.days) {
      this.status = statusList['end'];
    }
    return this.status == statusList['running'];
  }
}
