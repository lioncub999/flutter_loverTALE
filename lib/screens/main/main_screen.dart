import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_lover_tale/screens/initial/couple/couple_request_screen.dart';
import 'package:flutter_lover_tale/screens/initial/couple/sign_couple_screen.dart';
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
  int buttonState = 0;

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: Row(
              children: [
                // 메인 사진
                SizedBox(
                  width: mq.width * .45,
                  height: mq.height * .2,
                  child: APIs.me.coupleId.isNotEmpty
                      ? SizedBox(
                          width: mq.width * .45,
                          height: mq.width * .45,
                          // 커플 대표 사진 가져오기
                          child: Image.asset("$commonPath/main/main_default.png"),
                        )
                      : Container(
                          width: mq.width * .45,
                          height: mq.width * .45,
                          decoration: BoxDecoration(color: unselectGreyColor, borderRadius: BorderRadius.circular(15)),
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
                                  height: mq.height * .02,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: mq.width * .05,
                                        child: Image.asset('$commonPath/main/main_heart.png'),
                                      ),
                                      const Text("우리가 연결된 지")
                                    ],
                                  ),
                                ),
                                // 우리가 연결된지 - D-day
                                SizedBox(
                                  width: mq.width * .45,
                                  height: mq.height * .06,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("+ 188", style: TextStyle(fontSize: mq.width * .1, fontWeight: FontWeight.w900, color: const Color.fromRGBO(255, 122, 122, 1))),
                                      Text(" 일", style: TextStyle(fontSize: mq.width * .04, color: greyColor))
                                    ],
                                  ),
                                ),
                                // 우리가 연결된지 - 가까운 기념일
                                SizedBox(
                                  width: mq.width * .45,
                                  height: mq.height * .11,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: mq.height * .02,
                                        child: Text(
                                          "   가까운 기념일",
                                          style: TextStyle(fontSize: mq.width * .03),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: mq.width * .02),
                                        child: SizedBox(
                                          height: mq.height * .08,
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
                                                    height: mq.height * .05, // Adjust the height as needed
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
              ],
            ),
          ),
        ),
        // ┏━━━━━━━━━━━━━━━━━━━━━━┓
        // ┃  중앙 사진첩 콘텐츠  ┃
        // ┗━━━━━━━━━━━━━━━━━━━━━━┛
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
                child: Image.asset('$commonPath/main/spring_trip.png'),
              ),
              SizedBox(
                width: mq.width * .4,
                height: mq.width * .4,
                child: Image.asset('$commonPath/main/summer_trip.png'),
              ),
              SizedBox(
                width: mq.width * .4,
                height: mq.width * .4,
                child: Image.asset('$commonPath/main/spring_trip.png'),
              ),
            ],
          ),
        ),
        // ┏━━━━━━━━━━━━━━━┓
        // ┃  하단 캐러셀  ┃
        // ┗━━━━━━━━━━━━━━━┛
        SizedBox(
            width: mq.width,
            height: mq.height * .3,
            child: Swiper(
              pagination: SwiperPagination(
                  margin: EdgeInsets.zero,
                  builder: SwiperCustomPagination(builder: (context, config) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints.expand(height: 50.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: DotSwiperPaginationBuilder(
                                  color: unselectGreyColor,
                                  activeColor: greyColor,
                                  size: 8.0,
                                  activeSize: 8.0)
                                  .build(context, config),
                            ),
                          )
                        ],
                      ),
                    );
                  })),

              itemBuilder: (context, index) {
                return Container(
                  child: [SvgPicture.asset('$commonPath/main/main_diary.svg'), SvgPicture.asset('$commonPath/main/main_map.svg')][index],
                );
              },
              onIndexChanged: (value) => {
                setState(() {
                  buttonState = value;
                })
              },
              itemCount: 2,
              loop: false,
              viewportFraction: .5,
              scale: .4,
              containerWidth: mq.width,
              fade: .1,
            )),
        SizedBox(
          width: mq.width,
          height: mq.height * .08,
          child: Center(
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                fixedSize: Size(mq.width * .8, mq.height * .05),
                backgroundColor: Colors.orange,
              ),
              child:
              buttonState == 0 ?
              Text("다이어리 쓰러 가기", style: TextStyle(color: whiteColor))
              :
              Text("지도 보기", style: TextStyle(color: whiteColor))
              ,
            ),
          ),
        )
      ]),
    );
  }
}
