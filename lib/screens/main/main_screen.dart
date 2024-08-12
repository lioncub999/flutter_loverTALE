import 'dart:ui';

import 'package:flutter/material.dart';

import '../../apis/apis.dart';
import '../../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                             ┃
// ┃                                 메인 홈 화면                                ┃
// ┃                                                                             ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: mq.height * .01),
          // ┏━━━━━━━━━━━━━━━┓
          // ┃  상단 콘텐츠  ┃
          // ┗━━━━━━━━━━━━━━━┛
          child: Row(
            children: [
              // 좌측 공백
              SizedBox(
                width: mq.width * .05,
                height: mq.width * .45,
              ),
              // 메인 사진
              SizedBox(
                width: mq.width * .45,
                height: mq.width * .45,
                child: Image.asset("assets/common/main/main_default.png"),
              ),
              // 우리가 연결된지
              SizedBox(
                width: mq.width * .45,
                height: mq.width * .45,
                child:
                    // 커플이 연결 돼있으면 커플화면
                    APIs.me.coupleId.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                width: mq.width * .45,
                                height: mq.width * .08,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      child: Image.asset('assets/common/main/main_heart.png'),
                                    ),
                                    const Text("우리가 연결된 지")
                                  ],
                                ),
                              ),
                              // 우리가 연결된지 - D-day
                              SizedBox(
                                width: mq.width * .45,
                                height: mq.width * .12,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("+ 188",
                                        style: TextStyle(
                                            fontSize: mq.width * .1,
                                            color: const Color.fromRGBO(109, 109, 109, 1))),
                                    Text(" 일",
                                        style: TextStyle(
                                            fontSize: mq.width * .04,
                                            color: const Color.fromRGBO(109, 109, 109, 1)))
                                  ],
                                ),
                              ),
                              // 우리가 연결된지 - 가까운 기념일
                              SizedBox(
                                width: mq.width * .45,
                                height: mq.width * .25,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: mq.width * .04,
                                      child: Text(
                                        "   가까운 기념일",
                                        style: TextStyle(fontSize: mq.width * .03),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: mq.width * .02),
                                      child: SizedBox(
                                        height: mq.width * .18,
                                        child: Stack(
                                          children: [
                                            ListView(
                                              children: const [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [Text("+200일"), Text("2024.09.11")],
                                                ),
                                              ],
                                            ),
                                            // 하단 더보기 블러 처리
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: IgnorePointer(
                                                child: Container(
                                                  height:
                                                      mq.width * .1, // Adjust the height as needed
                                                  decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Color.fromRGBO(245, 245, 245, 0),
                                                        Color.fromRGBO(245, 245, 245, 0.5),
                                                        Color.fromRGBO(245, 245, 245, 0.7),
                                                        Color.fromRGBO(245, 245, 245, 0.9),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        :
                        // 커플 미등록 시 문구
                        const Center(
                            child: Text("커플 연결이 필요해요"),
                          ),
              ),
              // 우측 공백
              SizedBox(
                width: mq.width * .05,
              )
            ],
          ),
        ),
        // ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
        // ┃  가운데 사진첩 콘텐츠  ┃
        // ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
        SizedBox(
          width: mq.width,
          height: mq.height * .2,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: mq.width * .05,
                height: mq.width * .4,
              ),
              SizedBox(
                width: mq.width * .4,
                height: mq.width * .4,
                child: Image.asset('assets/common/main/spring_trip.png'),
              ),
              SizedBox(
                width: mq.width * .4,
                height: mq.width * .4,
                child: Image.asset('assets/common/main/summer_trip.png'),
              ),
              SizedBox(
                width: mq.width * .4,
                height: mq.width * .4,
                child: Image.asset('assets/common/main/spring_trip.png'),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
