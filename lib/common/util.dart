import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:oktoast/oktoast.dart';
import '../common/constant.dart';
import 'dart:math';

class Utils {
  static Random rng = new Random();

  static Color transStr(String c, {alpha = 255}) {
    return Color(int.parse(c, radix: 16)).withAlpha(alpha);
  }

  static Color getColorBg() {
    return transStr(Constants.colorMain);
  }

  static Color getPercentColor(int val, int target) {
    var percent = val / target;
    if (percent < 0.33) {
      return transStr(Constants.colorError);
    } else if (percent < 0.66) {
      return transStr(Constants.colorGood);
    } else {
      return transStr(Constants.colorSuccess);
    }
  }

  static String getPercentText(
    int val,
    int target,
  ) {
    var percent = val / target;
    assert(Constants != null && Constants.courageList != null);
    if (percent < 0.33) {
      var i = getRandomInit(Constants.courageList['low'].length);
      return Constants.courageList['low'][i];
    } else if (percent < 0.66) {
      var i = getRandomInit(Constants.courageList['low'].length);
      return Constants.courageList['low'][i];
    } else {
      var i = getRandomInit(Constants.courageList['low'].length);
      return Constants.courageList['low'][i];
    }
  }

  static int getDayInWeek() {
    var day = formatDate(DateTime.now(), [DD]);
    assert(Constants.days[day] != null);
    return Constants.days[day];
  }

  static String getFormatDate(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  static int getPassedDate(DateTime date) {
    var now = DateTime.now();
    return now.difference(date).inDays;
  }

  static int getRandomInit(int src) {
    return rng.nextInt(src);
  }

  static double getScreenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isWeekend(DateTime day) {
    return day.weekday == DateTime.sunday || day.weekday == DateTime.saturday;
  }

  static void showCommonToast(String toastText, Color bgColor,
      {int dur = 2000, ToastPosition pos = ToastPosition.top}) {
    showToast(toastText,
        duration: Duration(milliseconds: dur),
        position: pos,
        backgroundColor: bgColor.withOpacity(.8),
        radius: 18.0,
        textStyle: TextStyle(fontSize: 24.0),
        textPadding: const EdgeInsets.fromLTRB(28, 18, 28, 18));
  }

  static DateTime transferStrToDatetime(String dt) {
    if (dt == null || dt == 'null' || dt == 'none') {
      return null;
    } else {
      return DateTime.parse(dt);
    }
  }
}
