import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

import '../../main.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.height,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                width: mq.width,
                top: mq.height * .06,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                displayMonthTextStyle: TextStyle(color: Color.fromRGBO(109, 109, 109, 1.0), fontSize: 24),
                locale: 'ko',
                isExpanded: true,
                expandableDateFormat: 'yyyy MMMM dd., EEEE',
                showEvents: false,
                datePickerType: DatePickerType.date,
                topRowIconColor: Color.fromRGBO(174, 174, 174, 1.0),
                dayOfWeekStyle: TextStyle(color: Colors.transparent),
                dayBuilder: (BuildContext context, DateTime day) {
                  // 현재 월 구하기
                  DateTime now = DateTime.now();
                  bool isCurrentMonth = day.month == now.month;

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
                    height: mq.height * .05,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start, // 텍스트와 아이콘을 중앙 정렬
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          day.day.toString(),
                          style: TextStyle(color: dayColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 날짜가 2024년 9월 4일인 경우에만 아이콘을 표시
                            if (day.year == 2024 && day.month == 9 && day.day == 4) Container(width: mq.width * .04, height: mq.width * .04, child: Image.asset('assets/common/emoji_love.png'),),
                            if (day.year == 2024 && day.month == 9 && day.day == 4) Container(width: mq.width * .04, height: mq.width * .04, child: Image.asset('assets/common/emoji_love.png'),),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),)
            ],
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4, // 그림자 깊이 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.album,
                          color: Colors.blue,
                        ),
                        title: Text('남자 글'),
                        subtitle: Text('제목 같은거?'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _focusDate = DateTime.now();
              });
              _eventList.add(
                NeatCleanCalendarEvent(
                  'Custom Event',
                  startTime: DateTime.parse("2024-08-22"),
                  endTime: DateTime.parse("2024-08-22"),
                  description: 'This is a custom event',
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4, // 그림자 깊이 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.album,
                          color: Colors.pink,
                        ),
                        title: Text('여자 글'),
                        subtitle: Text('제목 같은거?'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text(_focusDate.toString())
        ],
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
          fontSize: 16,
        ),
      ));
    }

    return dayHeaders;
  }
}
