import 'package:flutter/material.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                  ┃
// ┃                                  CustomDateUtil                                  ┃
// ┃                                                                                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class CustomDateUtil {
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   milliSecondsSinceEpochs -> 날짜 형식으로 변환                     ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static String getOrgTime({required BuildContext context, required String date, required String returnType}) {
    final DateTime orgTime = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    late String month;
    late String day;

    if (orgTime.month < 10) {
      month = "0${orgTime.month}";
    } else {
      month = "${orgTime.month}";
    }

    if (orgTime.day < 10) {
      day = "0${orgTime.day}";
    } else {
      day = "${orgTime.day}";
    }
    switch (returnType) {
      case 'korYMD':
        return '${orgTime.year}년 $month월 $day일';
      case 'onlyMiddleBar':
        return '${orgTime.year}-$month-$day';
      case 'onlyDot':
        return '${orgTime.year}.$month.$day';
      default:
        return '${orgTime.year}-$month-$day';
    }
  }
}
