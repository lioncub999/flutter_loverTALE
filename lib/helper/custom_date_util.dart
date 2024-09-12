import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   milliSecondsSinceEpochs <-> 현재일 기준 날짜 차이 + 1 (사귄날)    ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static String getRelDate({required BuildContext context, required String loveStartDate}) {
    final DateTime loveDate = DateTime.fromMillisecondsSinceEpoch(int.parse(loveStartDate));
    DateTime onlyLoveDate = DateTime(loveDate.year, loveDate.month, loveDate.day);

    DateTime currentDate = DateTime.now();
    DateTime onlyCurrentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

    int difference = onlyCurrentDate.difference(onlyLoveDate).inDays + 1;

    return difference.toString();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   milliSecondsSinceEpochs 기준 100일 단위 기념일 구하기             ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static List<Object> calculateAnniversariesInRange(DateTime startDate, int intervalDays, int years, int count) {
    List<Object> anniversaries = [];
    for (int i = 1; i <= count; i++) {
      DateTime anniversary = startDate.add(Duration(days: intervalDays * i));
      if (anniversary.isBefore(DateTime.now().add(Duration(days: 365 * years))) && anniversary.isAfter(DateTime.now())) {
        String differenceDay = startDate.difference(anniversary).inDays.abs().toString();

        String millisecondsDate = anniversary.millisecondsSinceEpoch.toString();

        Object object = {"type": "day_after", "difference": differenceDay, "date": millisecondsDate};
        anniversaries.add(object);
      }
    }
    return anniversaries;
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   milliSecondsSinceEpochs 기준 몇년 +00 한 날의 날짜 구하기         ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static List<Object> calculateAnniversariesYear(DateTime startDate, int years, int count) {
    List<Object> anniversaries = [];
    for (int i = 1; i <= count; i++) {
      // 1년 더하기
      DateTime anniversary = DateTime(
        startDate.year + i,
        startDate.month,
        startDate.day,
      );
      if (anniversary.isBefore(DateTime.now().add(Duration(days: 365 * years))) && anniversary.isAfter(DateTime.now())) {
        String millisecondsDate = anniversary.millisecondsSinceEpoch.toString();

        Object object = {"type": "anniversary_year", "difference": i.toString(), "date": millisecondsDate};
        anniversaries.add(object);
      }
    }
    return anniversaries;
  }
}
