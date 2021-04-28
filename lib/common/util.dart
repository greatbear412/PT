import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
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
    return Constants.days[day];
  }

  static String getFormatDate(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
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
}
