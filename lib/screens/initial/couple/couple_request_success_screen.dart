import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/apis/user_apis.dart';
import 'package:flutter_lover_tale/models/user_model.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';

import '../../../main.dart';

class CoupleRequestSuccessScreen extends StatefulWidget {
  const CoupleRequestSuccessScreen({super.key, required this.partner});

  final ModuUser partner;

  @override
  State<CoupleRequestSuccessScreen> createState() => _CoupleRequestSuccessScreenState();
}

class _CoupleRequestSuccessScreenState extends State<CoupleRequestSuccessScreen> {
  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();

    // 데이터 로드가 완료되면 애니메이션 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isAnimated = true;
      });
    });

  }

  bool _isAnimated = false;

  List<ModuUser> _partnerInfo = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Stack(
            children: [
              AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  top: mq.height * .1,
                  left: mq.width * .1,
                  child: Container(
                    child: Text("안녕하세요!", style: TextStyle(color: Color.fromRGBO(255, 135, 81, 1.0), fontSize: mq.width * .04)),
                  )),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                top: mq.height * .13,
                left: mq.width * .1,
                child: FutureBuilder(
                    future: UserAPIs.getUserInfoFromUserCode(widget.partner),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("");
                      } else if (snapshot.hasError) {
                        return Text("Error : ${snapshot}");
                      } else {
                        final data = snapshot.data?.docs;
                        // API로 받아온 데이터 MessageList 에 저장
                        _partnerInfo = data?.map((e) => ModuUser.fromJson(e.data())).toList() ?? [];
                        return Text(
                          "${_partnerInfo[0].name} 님과의",
                          style: TextStyle(color: greyColor, fontSize: mq.width * .07, letterSpacing: -mq.width * .005),
                        );
                    }
                    })
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                top: mq.height * .17,
                left: mq.width * .1,
                child: Text(
                  "이야기가 시작되었습니다!",
                  style: TextStyle(color: greyColor, fontSize: mq.width * .07, letterSpacing: -mq.width * .005),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                width: mq.width * .5,
                top: _isAnimated ? mq.height * .4 : mq.height * .45,
                left: mq.width * .25,
                child: Image.asset("$commonPath/etc/pop_origin.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: mq.height * .5,
                left: _isAnimated ? mq.width * .02 : mq.width * .15,
                child: Image.asset("$commonPath/etc/pop_particle_1.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .47 : mq.height * .5,
                left: _isAnimated ? mq.width * .14 : mq.width * .3,
                child: Image.asset("$commonPath/etc/pop_particle_2.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .44 : mq.height * .47,
                left: _isAnimated ? mq.width * .01 : mq.width * .1,
                child: Image.asset("$commonPath/etc/pop_particle_3.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .41 : mq.height * .45,
                left: _isAnimated ? mq.width * .06 : mq.width * .14,
                child: Image.asset("$commonPath/etc/pop_particle_4.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .405 : mq.height * .45,
                left: _isAnimated ? mq.width * .18 : mq.width * .3,
                child: Image.asset("$commonPath/etc/pop_particle_5.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .37 : mq.height * .45,
                left: _isAnimated ? mq.width * .19 : mq.width * .32,
                child: Image.asset("$commonPath/etc/pop_particle_6.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .33 : mq.height * .42,
                left: _isAnimated ? mq.width * .1 : mq.width * .2,
                child: Image.asset("$commonPath/etc/pop_particle_7.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .3 : mq.height * .4,
                left: _isAnimated ? mq.width * .15 : mq.width * .2,
                child: Image.asset("$commonPath/etc/pop_particle_8.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .28 : mq.height * .35,
                left: _isAnimated ? mq.width * .21 : mq.width * .3,
                child: Image.asset("$commonPath/etc/pop_particle_9.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .34 : mq.height * .38,
                left: _isAnimated ? mq.width * .28 : mq.width * .34,
                child: Image.asset("$commonPath/etc/pop_particle_10.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .29 : mq.height * .35,
                left: _isAnimated ? mq.width * .32 : mq.width * .35,
                child: Image.asset("$commonPath/etc/pop_particle_11.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .31 : mq.height * .36,
                left: _isAnimated ? mq.width * .37 : mq.width * .39,
                child: Image.asset("$commonPath/etc/pop_particle_12.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .33 : mq.height * .38,
                left: _isAnimated ? mq.width * .38 : mq.width * .4,
                child: Image.asset("$commonPath/etc/pop_particle_13.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .25 : mq.height * .33,
                left: _isAnimated ? mq.width * .42 : mq.width * .43,
                child: Image.asset("$commonPath/etc/pop_particle_14.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .3 : mq.height * .35,
                left: _isAnimated ? mq.width * .49 : mq.width * .48,
                child: Image.asset("$commonPath/etc/pop_particle_15.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .34 : mq.height * .37,
                left: _isAnimated ? mq.width * .53 : mq.width * .52,
                child: Image.asset("$commonPath/etc/pop_particle_16.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .27 : mq.height * .33,
                left: _isAnimated ? mq.width * .55 : mq.width * .54,
                child: Image.asset("$commonPath/etc/pop_particle_17.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .32 : mq.height * .35,
                left: _isAnimated ? mq.width * .58 : mq.width * .56,
                child: Image.asset("$commonPath/etc/pop_particle_18.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .29 : mq.height * .35,
                left: _isAnimated ? mq.width * .64 : mq.width * .62,
                child: Image.asset("$commonPath/etc/pop_particle_19.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .36 : mq.height * .39,
                left: _isAnimated ? mq.width * .65 : mq.width * .63,
                child: Image.asset("$commonPath/etc/pop_particle_20.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .28 : mq.height * .35,
                left: _isAnimated ? mq.width * .69 : mq.width * .67,
                child: Image.asset("$commonPath/etc/pop_particle_21.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .27 : mq.height * .35,
                left: _isAnimated ? mq.width * .74 : mq.width * .72,
                child: Image.asset("$commonPath/etc/pop_particle_22.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .33 : mq.height * .36,
                left: _isAnimated ? mq.width * .73 : mq.width * .68,
                child: Image.asset("$commonPath/etc/pop_particle_23.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .29 : mq.height * .35,
                left: _isAnimated ? mq.width * .82 : mq.width * .77,
                child: Image.asset("$commonPath/etc/pop_particle_24.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .31 : mq.height * .35,
                left: _isAnimated ? mq.width * .86 : mq.width * .84,
                child: Image.asset("$commonPath/etc/pop_particle_25.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .35 : mq.height * .38,
                left: _isAnimated ? mq.width * .83 : mq.width * .8,
                child: Image.asset("$commonPath/etc/pop_particle_26.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .38 : mq.height * .4,
                left: _isAnimated ? mq.width * .8 : mq.width * .72,
                child: Image.asset("$commonPath/etc/pop_particle_27.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .36 : mq.height * .4,
                left: _isAnimated ? mq.width * .88 : mq.width * .76,
                child: Image.asset("$commonPath/etc/pop_particle_28.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .4 : mq.height * .42,
                left: _isAnimated ? mq.width * .85 : mq.width * .75,
                child: Image.asset("$commonPath/etc/pop_particle_29.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .47 : mq.height * .5,
                left: _isAnimated ? mq.width * .8 : mq.width * .75,
                child: Image.asset("$commonPath/etc/pop_particle_30.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .49 : mq.height * .49,
                left: _isAnimated ? mq.width * .88 : mq.width * .8,
                child: Image.asset("$commonPath/etc/pop_particle_31.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .5 : mq.height * .5,
                left: _isAnimated ? mq.width * .89 : mq.width * .82,
                child: Image.asset("$commonPath/etc/pop_particle_32.png"),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds : 500),
                curve: Curves.bounceOut,
                top: _isAnimated ? mq.height * .53 : mq.height * .53,
                left: _isAnimated ? mq.width * .98 : mq.width * .9,
                child: Image.asset("$commonPath/etc/pop_particle_33.png"),
              ),
              Positioned(
                top: mq.height * .8,
                left: mq.width * .1,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(253, 150, 150, 1.0),
                      spreadRadius: 1, // 그림자 퍼짐 정도
                      blurRadius: 10, // 그림자의 흐려짐 정도
                      offset: Offset(0, 0), // 그림자의 위치 (x축, y축 이동값)
                    )
                  ]),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(mq.width * .8, mq.height * .07),
                        backgroundColor: Color.fromRGBO(255, 122, 122, 1.0),
                        padding: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("등록완료", style: TextStyle(color: whiteColor, fontSize: mq.width * .07, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        // 등록 완료 버튼
      ),
    );
  }
}
