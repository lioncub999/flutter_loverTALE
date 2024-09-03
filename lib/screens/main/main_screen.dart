import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/svg.dart';

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
                height: mq.height * .2,
              ),
              // 메인 사진
              SizedBox(
                width: mq.width * .45,
                height: mq.height * .2,
                child: SizedBox(
                  width: mq.width * .45,
                  height: mq.width * .45,
                  child: Image.asset("assets/common/main/main_default.png"),
                ),
              ),
              // 우리가 연결된지
              SizedBox(
                width: mq.width * .45,
                height: mq.height * .2,
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
                                    Text("+ 188", style: TextStyle(fontSize: mq.width * .1, fontWeight: FontWeight.w900,  color: const Color.fromRGBO(255, 122, 122, 1))),
                                    Text(" 일", style: TextStyle(fontSize: mq.width * .04, color: const Color.fromRGBO(109, 109, 109, 1)))
                                  ],
                                ),
                              ),
                              // 우리가 연결된지 - 가까운 기념일
                              SizedBox(
                                width: mq.width * .45,
                                height: mq.width * .23,
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
                                        height: mq.width * .13,
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
                                                  height: mq.width * .1, // Adjust the height as needed
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
                height: mq.height * .2,
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
        ),
        SizedBox(
          width: mq.width,
          height: mq.height * .35,
          child: ImageSlideshow(

            // 초기 페이지
            initialPage: 0,

            // 선택 된 인디케이터 색상
            indicatorColor: const Color.fromRGBO(109, 109, 109, 1.0),

            // 선택 안된 인디케이터 색상
            indicatorBackgroundColor: const Color.fromRGBO(188, 188, 188, 1.0),
            indicatorPadding: mq.width * .02,

            // 화면 변경됐을때 실행 함수 (value = 현재 index)
            // onPageChanged: (value) {
            // },

            // 오토 플레이. 시간
            // autoPlayInterval: 3000,

            // 끝까지 갔을때 루프 시킬건지
            isLoop: true,

            // 캐러샐 안에 들어갈 컨텐츠
            children: [
              Stack(
                children: [
                  Positioned(
                      child: Center(
                    child: SvgPicture.asset('assets/common/main/main_diary.svg'),
                  )),
                  Positioned(
                      width: mq.width * .7,
                      height: mq.height * .07,
                      top: mq.height * .18,
                      left: mq.width * .15,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(242, 113, 65, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "다이어리 쓰러 가기",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Icon(Icons.pin_end),
                          ],
                        ),
                      ))
                ],
              ),
              Stack(
                children: [
                  Positioned(
                      child: Center(
                        child: SvgPicture.asset('assets/common/main/main_map.svg'),
                      )),
                  Positioned(
                      width: mq.width * .5,
                      height: mq.height * .07,
                      top: mq.height * .18,
                      left: mq.width * .25,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(242, 113, 65, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "지도 보기",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Icon(Icons.pin),
                          ],
                        ),
                      ))
                ],
              ),
              const Center(
                child: Text("세번째 화면"),
              )
            ],
          ),
        )
      ]),
    );
  }
}
