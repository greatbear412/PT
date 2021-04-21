import 'package:flutter/material.dart';

const color_main = '060a27';
const color_normal = 'C5C6B6';
const color_warning = 'FFBC42';
const color_good = '84B1ED';
const color_success = '67D5B5';
const color_error = 'ff1b43';

class Utils {
  static Color transStr(String c) {
    return Color(int.parse(c, radix: 16)).withAlpha(255);
  }

  static Color getColorBg() {
    return transStr(color_main);
  }

  static Color getPercentColor(int val, int target) {
    var percent = val / target;
    if (percent < 0.33) {
      return transStr(color_error);
    } else if (percent < 0.66) {
      return transStr(color_good);
    } else {
      return transStr(color_success);
    }
  }

  // static String getPercentText(int val, int target, ) {
  //   var percent = val / target;
  //   if (percent < 0.33) {
  //     return transStr(color_error);
  //   } else if (percent < 0.66) {
  //     return transStr(color_good);
  //   } else {
  //     return transStr(color_success);
  //   }
  // }
}
