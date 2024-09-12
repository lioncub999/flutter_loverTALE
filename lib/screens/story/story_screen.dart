import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                             ┃
// ┃                                이야기 탭 화면                               ┃
// ┃                                                                             ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  DateTime _focusDate = DateTime.now();
  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent('MultiDay Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        color: Colors.blue,
        isMultiDay: true),
    NeatCleanCalendarEvent('Allday Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        color: Colors.pink,
        isAllDay: true),
  ];

  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  @override
  Widget build(BuildContext context) {
    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: baseWhite,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  width: mq.width,
                  top: mq.height * .06,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: mq.height * .015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _buildWeekDays(), // 요일 헤더 커스텀
                    ),
                  ),
                ),
                Positioned(
                  child: Calendar(
                    onDateSelected: (value) => setState(
                      () {
                        _focusDate = value;
                        print(_focusDate);
                      },
                    ),
                    eventsList: _eventList,
                    startOnMonday: false,
                    showEventListViewIcon: false,
                    weekDays: ['', '', '', '', '', '', ''],
                    allDayEventText: '',
                    eventColor: null,
                    todayColor: Colors.black,
                    selectedTodayColor: Colors.black,
                    hideTodayIcon: true,
                    displayMonthTextStyle: TextStyle(color: Color.fromRGBO(109, 109, 109, 1.0), fontSize: mq.width * .065),
                    locale: 'ko',
                    isExpanded: true,
                    expandableDateFormat: 'yyyy MMMM dd., EEEE',
                    showEvents: false,
                    datePickerType: DatePickerType.date,
                    topRowIconColor: const Color.fromRGBO(174, 174, 174, 1.0),
                    dayOfWeekStyle: const TextStyle(color: Colors.transparent),
                    dayBuilder: (BuildContext context, DateTime day) {
                      // 날짜 색상 설정
                      Color dayColor = Color.fromRGBO(109, 109, 109, 1.0); // 기본 텍스트 색상.

                      if (day.weekday == DateTime.sunday) {
                        dayColor = Color.fromRGBO(255, 122, 122, 1.0); // 현재 달의 일요일
                      } else if (day.weekday == DateTime.saturday) {
                        dayColor = Color.fromRGBO(255, 135, 81, 1); // 현재 달의 토요일
                      }
                      if (day.month != _focusDate.month) {
                        dayColor = Color.fromRGBO(214, 214, 214, 1.0); // 이전 달 또는 다음 달의 날짜
                      }

                      return Container(
                        color: baseWhite,
                        width: mq.width * .1,
                        height: mq.width * .09,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start, // 텍스트와 아이콘을 중앙 정렬
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _focusDate.year == day.year && _focusDate.month == day.month
                            && _focusDate.day == day.day
                            ?
                            Container(
                              width: mq.width * .05,
                              height: mq.width * .05,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(216, 219, 230, 1.0),
                                borderRadius: BorderRadius.circular(mq.width * .025)
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  day.day.toString(),
                                  style: TextStyle(color: dayColor, fontSize: mq.width * .035),
                                ),
                              )
                            )
                            :
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(color: dayColor, fontSize: mq.width * .035),
                              ),
                            )
                            ,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 날짜가 2024년 9월 4일인 경우에만 아이콘을 표시
                                if (day.year == 2024 && day.month == 9 && day.day == 4)
                                  Container(
                                    width: mq.width * .04,
                                    height: mq.width * .04,
                                    child: Image.asset('assets/common/emoji_love.png'),
                                  ),
                                if (day.year == 2024 && day.month == 9 && day.day == 4)
                                  Container(
                                    width: mq.width * .04,
                                    height: mq.width * .04,
                                    child: Image.asset('assets/common/emoji_love.png'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Container(
              color: Colors.white,
              width: mq.width,
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width * .8,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("7"), Text("다이어리 작성하기")],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: mq.height * .01),
                    child: SizedBox(
                      width: mq.width * .9,
                      child: InkWell(
                        onTap: () {
                        },
                        child: Card(
                            color: const Color.fromRGBO(216, 219, 230, 1.0),
                            elevation: 1, // 그림자 깊이 설정
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
                            ),
                            child: SizedBox(
                              height: mq.height * .12,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: mq.width * .05,
                                  ),
                                  SizedBox(
                                    width: mq.width * .15,
                                    height: mq.width * .15,
                                    child: ClipRRect(
                                      child: Image.asset("$commonPath/main/main_default.png"),
                                      borderRadius: BorderRadius.circular(mq.width * .075),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * .03,
                                  ),
                                  SizedBox(
                                    width: mq.width * .55,
                                    child: const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("신유리님이 작성한 이야기"),
                                        Text("2017에 작성됨")
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * .08,
                                    child: Center(
                                      child: SvgPicture.asset("$commonPath/arrow_right.svg"),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: mq.height * .01),
                    child: SizedBox(
                      width: mq.width * .9,
                      child: InkWell(
                        onTap: () {
                        },
                        child: Card(
                            color: const Color.fromRGBO(216, 219, 230, 1.0),
                            elevation: 1, // 그림자 깊이 설정
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
                            ),
                            child: SizedBox(
                              height: mq.height * .12,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: mq.width * .05,
                                  ),
                                  SizedBox(
                                    width: mq.width * .15,
                                    height: mq.width * .15,
                                    child: ClipRRect(
                                      child: Image.asset("$commonPath/main/main_default.png"),
                                      borderRadius: BorderRadius.circular(mq.width * .075),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * .03,
                                  ),
                                  SizedBox(
                                    width: mq.width * .55,
                                    child: const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("신유리님이 작성한 이야기"),
                                        Text("2017에 작성됨")
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * .08,
                                    child: Center(
                                      child: SvgPicture.asset("$commonPath/arrow_right.svg"),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Text(_focusDate.toString())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 요일 헤더를 커스텀하는 함수
  List<Widget> _buildWeekDays() {
    final List<String> weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    final List<Widget> dayHeaders = [];

    for (int i = 0; i < weekDays.length; i++) {
      Color textColor;

      if (i == 0) {
        textColor = Color.fromRGBO(255, 122, 122, 1.0); // 일요일 색상
      } else if (i == 6) {
        textColor = Color.fromRGBO(255, 135, 81, 1.0); // 토요일 색상
      } else {
        textColor = Colors.black; // 다른 요일 색상
      }

      dayHeaders.add(Text(
        weekDays[i],
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: mq.width * .04,
        ),
      ));
    }

    return dayHeaders;
  }
}
