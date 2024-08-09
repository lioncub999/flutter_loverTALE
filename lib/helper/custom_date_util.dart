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
  static String getOrgTime(
      {required BuildContext context, required String date, required String returnType}) {
    final DateTime orgTime = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    switch (returnType) {
      case 'korYMD':
        return '${orgTime.year}년 ${orgTime.month}월 ${orgTime.day}일';
      case 'onlyMiddleBar':
        return '${orgTime.year}-${orgTime.month}-${orgTime.day}';
      case 'onlyDot' :
        return '${orgTime.year}.${orgTime.month}.${orgTime.day}';
      default:
        return '${orgTime.year}-${orgTime.month}-${orgTime.day}';
    }
  }
}
