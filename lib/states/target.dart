import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../common/util.dart';
import '../common/constant.dart';
import '../common/bus.dart';

/// `@status`: 1. 正常； 2.失败； 3. 删除； 99. 完成
const Map<String, int> statusList = {
  'running': 1,
  'fail': 2,
  'delete': 3,
  'finish': 99,
};

class TargetListStates with ChangeNotifier, DiagnosticableTreeMixin {
  List<Target> _taskList = [
    Target(1, '早起', 1, status: 1),
    // Target(2, '背单词qweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee', 28, status: 1),
    // Target(3, '背单词', 14, status: 2),
    // Target(4, '背单词', 24, status: 2),
    // Target(5, '背单词', 13, status: 2),
    // Target(6, '背单词', 28, status: 2),
    // Target(7, '背单词', 14, status: 3),
    // Target(8, '背单词', 23, status: 3),
    // Target(9, '背单词', 23, status: 3),
    // Target(10, '背单词', 23, status: 3),
    // Target(11, '背单词', 24, status: 99),
    // Target(12, '背单词', 12, status: 99),
    // Target(13, '背单词', 176, status: 99),
    // Target(14, '背单词', 15, status: 99),
  ];

  List<Target> get taskList => _taskList;

  /// 修改`target`
  void modify(int id, String title, int days) {}

  /// 创建；并添加入 `_taskList` 列表
  void create(String title, int days) {
    var valid = getTargetList(status: 'running').length;
    if (valid < 3) {
      var lastId =
          _taskList.length == 0 ? 0 : _taskList[_taskList.length - 1].id;
      _taskList.add(Target(lastId + 1, title, days));
      notifyListeners();
    } else {
      // TODO: 提醒超额
    }
  }

  void edit(Target target, String title, int days) {
    target.edit(title, days);
    notifyListeners();
  }

  /// 签到
  void sign(Target target) {
    target.sign();
    notifyListeners();
  }

  /// 删除
  Target delete(Target target) {
    target.delete();
    notifyListeners();
    return target;
  }

  /// 放弃
  Target abolish(Target target) {
    target.abolish();
    notifyListeners();
    return target;
  }

  /// 放弃
  Target reStart(Target target) {
    target.reStart();
    notifyListeners();
    return target;
  }

  /// 获取任务
  List<Target> getTargetList({status}) {
    return status == null
        ? taskList
        : taskList
            .where((element) => element.status == statusList[status])
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
  bool finishToday;
  List<String> finishHistory;
  DateTime startTime;

  int status;
  DateTime lastFinish;

  Target(this.id, this.title, this.days,
      {this.status = 1, this.finishToday = false})
      : startTime = DateTime.now(),
        // : startTime = DateTime.now().subtract(const Duration(days: 10)),
        finishHistory = [
          // Utils.getFormatDate(DateTime.now().subtract(const Duration(days: 1))),
          // DateTime.now().subtract(const Duration(days: 4)),
          // DateTime.now().subtract(const Duration(days: 5)),
          // DateTime.now().subtract(const Duration(days: 7)),
          // Utils.getFormatDate(DateTime.now().subtract(const Duration(days: 10)))
        ];

  void sign() {
    this.finishToday = true;
    this.finishHistory.add(Utils.getFormatDate(DateTime.now()));
    this.lastFinish = DateTime.now();
    Utils.showCommonToast('给力！', Utils.transStr(Constants.colorSuccess));
    this.checkValid();
  }

  void edit(String title, int days) {
    this.title = title;
    this.days = days;
    Utils.showCommonToast('操作成功。', Utils.transStr(Constants.colorActive));
    this.checkValid();
  }

  void abolish() {
    this.status = statusList['fail'];
    Utils.showCommonToast('再见了...', Utils.transStr(Constants.colorMain));
  }

  void delete() {
    this.status = statusList['delete'];
    Utils.showCommonToast('永别了...', Utils.transStr(Constants.colorMain));
  }

  void reStart() {
    this.status = statusList['running'];
    this.finishHistory = [];
    this.finishToday = false;
    this.lastFinish = null;
    this.startTime = DateTime.now();
    Utils.showCommonToast('为自己加油！', Utils.transStr(Constants.colorGood));
  }

  /// 每次启动时自检：重置所有finishToday；
  /// 启动定时器：第二天3点时再次自检
  void checkSelf() {}

  //任务是否有效；是否已经达成
  bool checkValid() {
    if (this.finishHistory.length >= this.days) {
      this.status = statusList['finish'];
      bus.emit("finish", this);
    }
    return this.status == statusList['running'];
  }
}
