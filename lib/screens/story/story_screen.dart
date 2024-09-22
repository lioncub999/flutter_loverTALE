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
  // 선택한 날짜
  DateTime _focusDate = DateTime.now();

  // 이벤트 리스트
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
    // 오버 스크롤 오류 방지용 SingleChildScrollView
    return SingleChildScrollView(
      // 스프링 스크롤 막기
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: baseWhite,
        child: Column(
          children: [
            Stack(
              children: [
                // ┏━━━━━━━━━━━━━━━━━━━━┓
                // ┃  커스텀 요일 헤더  ┃
                // ┗━━━━━━━━━━━━━━━━━━━━┛
                Positioned(
                  width: mq.width,
                  top: mq.height * .06,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: mq.height * .015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _buildWeekDays(),
                    ),
                  ),
                ),
                // ┏━━━━━━━━━━┓
                // ┃  캘린더  ┃
                // ┗━━━━━━━━━━┛
                Positioned(
                  child: Calendar(
                    // 날짜 선택 시 실행 함수
                    onDateSelected: (value) => setState(
                      () {
                        _focusDate = value;
                        print(_focusDate);
                      },
                    ),
                    // 좌우 화살표로 달 변경 시 실행 함수
                    onMonthChanged: (value) => {},
                    // 이벤트 리스트
                    eventsList: _eventList,
                    startOnMonday: false,
                    showEventListViewIcon: false,
                    weekDays: const ['', '', '', '', '', '', ''],
                    allDayEventText: '',
                    eventColor: null,
                    todayColor: Colors.black,
                    selectedTodayColor: Colors.black,
                    hideTodayIcon: true,
                    displayMonthTextStyle: TextStyle(color: greyColor, fontSize: mq.width * .065),
                    locale: 'ko',
                    isExpanded: true,
                    expandableDateFormat: 'yyyy MMMM dd., EEEE',
                    showEvents: false,
                    datePickerType: DatePickerType.date,
                    topRowIconColor: const Color.fromRGBO(174, 174, 174, 1.0),
                    dayOfWeekStyle: const TextStyle(color: Colors.transparent),
                    // 캘린더 셀 내부 내용 빌더
                    dayBuilder: (BuildContext context, DateTime day) {
                      // 날짜 색상 설정
                      Color dayColor = greyColor; // 기본 텍스트 색상.

                      if (day.weekday == DateTime.sunday) {
                        dayColor = const Color.fromRGBO(255, 122, 122, 1.0); // 현재 달의 일요일
                      } else if (day.weekday == DateTime.saturday) {
                        dayColor = const Color.fromRGBO(255, 135, 81, 1); // 현재 달의 토요일
                      }
                      if (day.month != _focusDate.month) {
                        dayColor = const Color.fromRGBO(214, 214, 214, 1.0); // 이전 달 또는 다음 달의 날짜
                      }

                      return Container(
                        color: baseWhite,
                        width: mq.width * .1,
                        height: mq.width * .09,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start, // 텍스트와 아이콘을 중앙 정렬
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _focusDate.year == day.year && _focusDate.month == day.month && _focusDate.day == day.day
                                ? Container(
                                    width: mq.width * .05,
                                    height: mq.width * .05,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(216, 219, 230, 1.0), borderRadius: BorderRadius.circular(mq.width * .025)),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        day.day.toString(),
                                        style: TextStyle(color: dayColor, fontSize: mq.width * .035),
                                      ),
                                    ))
                                : Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      day.day.toString(),
                                      style: TextStyle(color: dayColor, fontSize: mq.width * .035),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 이벤트 리스트에 해당일 이벤트가 있으면 이모티콘 표시
                                if (day.year == 2024 && day.month == 9 && day.day == 4)
                                  SizedBox(
                                    width: mq.width * .04,
                                    height: mq.width * .04,
                                    child: Image.asset('$commonPath/emoji/emoji_love.png'),
                                  ),
                                if (day.year == 2024 && day.month == 9 && day.day == 4)
                                  SizedBox(
                                    width: mq.width * .04,
                                    height: mq.width * .04,
                                    child: Image.asset('$commonPath/emoji/emoji_love.png'),
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
            // ┏━━━━━━━━━━━━━━━┓
            // ┃  하단 컨텐츠  ┃
            // ┗━━━━━━━━━━━━━━━┛
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: mq.width, minHeight: mq.height * .4),
              child: Container(
                color: Colors.white,
                child: Stack(children: [
                  Positioned(
                    left: mq.width * .04,
                    bottom: 0,
                    child: Image.asset("$commonPath/character/girl_story.png"),
                  ),
                  Positioned(
                    right: mq.width * .04,
                    bottom: 0,
                    child: Image.asset("$commonPath/character/man_story.png"),
                  ),
                  SizedBox(
                    width: mq.width,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: mq.height * .02),
                          width: mq.width * .9,
                          height: mq.height * .08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: mq.width * .15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(_focusDate.day.toString(),
                                        style: TextStyle(
                                            fontSize: mq.width * .1, height: mq.height * .0013, color: greyColor, fontWeight: FontWeight.w800)),
                                    Text(
                                        _focusDate.weekday == 1
                                            ? "Mon"
                                            : _focusDate.weekday == 2
                                                ? "Tue"
                                                : _focusDate.weekday == 3
                                                    ? "Wed"
                                                    : _focusDate.weekday == 4
                                                        ? "Thu"
                                                        : _focusDate.weekday == 5
                                                            ? "Fri"
                                                            : _focusDate.weekday == 6
                                                                ? "Sat"
                                                                : _focusDate.weekday == 7
                                                                    ? "Sun"
                                                                    : "Error",
                                        style: TextStyle(fontSize: mq.width * .04, color: greyColor, fontWeight: FontWeight.w700))
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    overlayColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    print(_focusDate);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "다이어리 작성하기 ",
                                        style: TextStyle(
                                            fontSize: mq.width * .04, color: Color.fromRGBO(255, 135, 81, 1.0), fontWeight: FontWeight.w700),
                                      ),
                                      SvgPicture.asset(
                                        "$commonPath/line_arrow_right.svg",
                                        width: mq.width * .04,
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: mq.height * .01),
                          child: SizedBox(
                            width: mq.width * .9,
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                  color: const Color.fromRGBO(216, 219, 230, .8),
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
                                            borderRadius: BorderRadius.circular(mq.width * .075),
                                            child: Image.asset("$commonPath/main/main_default.png"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: mq.width * .03,
                                        ),
                                        SizedBox(
                                          width: mq.width * .55,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                    style: TextStyle(
                                                      fontSize: mq.width * .04,
                                                      color: greyColor,
                                                      decorationStyle: TextDecorationStyle.solid, // 밑줄 스타일
                                                      decorationColor: greyColor, // 밑줄 색상
                                                    ),
                                                    children: [
                                                      TextSpan(text: "신유리", style: TextStyle(decoration: TextDecoration.underline)),
                                                      TextSpan(text: "님이 작성한 이야기"),
                                                    ]),
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "$commonPath/emoji/emoji_love.png",
                                                    width: mq.width * .05,
                                                  ),
                                                  Text(
                                                    " 20:17 에 작성됨",
                                                    style: TextStyle(fontSize: mq.width * .03, color: greyColor),
                                                  )
                                                ],
                                              )
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

                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ┏━━━━━━━━━━━━━━━━━━━━┓
  // ┃  커스텀 요일 헤더  ┃
  // ┗━━━━━━━━━━━━━━━━━━━━┛
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
