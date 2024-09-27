import 'dart:ui';

import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/histmap/hist_map_screen.dart';
import 'package:flutter_lover_tale/screens/initial/info_insert_screen.dart';
import 'package:flutter_lover_tale/screens/auth/login_screen.dart';
import 'package:flutter_lover_tale/screens/mypage/mypage_screen.dart';
import 'package:flutter_lover_tale/screens/story/story_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../apis/apis.dart';
import '../apis/user_apis.dart';
import '../main.dart';
import '../service/admob_service.dart';
import 'main/main_screen.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                                 홈 화면                                    ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // 광고 배너 관련
  BannerAd? _bannerAd;
  bool _bannerIsLoaded = false;

  // 배너 광고 생성
  void _createBannerAd() {
    setState(() {
      _bannerAd = BannerAd(
          size: AdSize.fullBanner, adUnitId: AdMobService.bannerAdUnitId!, listener: AdMobService.bannerAdListener, request: const AdRequest())
        ..load();
      _bannerIsLoaded = true;
    });
  }

  // Tap 기능 관리 State
  bool isScrollable = false;
  bool showNextIcon = false;
  bool showBackIcon = false;

  // 탭 별 화면
  List<TabData> tabs = [
    TabData(
        index: 0,
        title: const Tab(
          child: Text('     홈     '),
        ),
        content: const MainScreen()),
    TabData(
      index: 1,
      title: const Tab(
        child: Text('  이야기  '),
      ),
      content: StoryScreen(),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('추억 지도'),
      ),
      content: const HistMapScreen(),
    ),
    TabData(
      index: 3,
      title: const Tab(
        child: Text('  내정보  '),
      ),
      content: const MypageScreen(),
    ),
  ];

  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  Widget build(BuildContext context) {
    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    // ┃  현재 로그인 유저 정보 확인을 위한 FutureBuilder  ┃
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    return FutureBuilder(
        future: UserAPIs.getSelfInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
            // ┃  me.id 가 비어 있으면 로그인 화면으로  ┃
            // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
            if (APIs.me.id.isEmpty) {
              return const LoginScreen();
            }
            // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
            // ┃  기본 정보 등록 확인 (이름 & 성별 & 생일)  ┃
            // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
            if (APIs.me.name.isNotEmpty && APIs.me.gender.isNotEmpty && APIs.me.birthDay.isNotEmpty) {
              return Scaffold(
                // ┏━━━━━━━━━━━━┓
                // ┃   AppBar   ┃
                // ┗━━━━━━━━━━━━┛
                appBar: AppBar(
                  title: SvgPicture.asset(
                    '$commonPath/logo/lover_tale_logo.svg',
                    width: mq.width * .05,
                    height: mq.width * .05,
                  ),
                  // AppBar - Actions
                  actions: [
                    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                    // ┃   AppBar - actions - 알림  ┃
                    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await APIs.auth.signOut();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                      },
                      child: SvgPicture.asset(
                        "$commonPath/icon/alert_icon.svg",
                        width: mq.width * .035,
                      ),
                    )
                  ],
                ),
                body:
                    // ┏━━━━━━━━━━━━━━━━━━━━━━━┓
                    // ┃   Body - Tap + 화면   ┃
                    // ┗━━━━━━━━━━━━━━━━━━━━━━━┛
                    Container(
                  color: baseWhite,
                  width: mq.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: DynamicTabBarWidget(
                          padding: EdgeInsets.zero,
                          dividerHeight: 0,
                          labelColor: greyColor,
                          unselectedLabelColor: unselectGreyColor,
                          indicatorColor: greyColor,
                          dynamicTabs: tabs,
                          isScrollable: isScrollable,
                          onTabControllerUpdated: (controller) {},
                          onTabChanged: (index) {},
                          onAddTabMoveTo: MoveToTab.last,
                          showBackIcon: showBackIcon,
                          showNextIcon: showNextIcon,
                        ),
                      ),
                      // ┏━━━━━━━━━━━━━┓
                      // ┃  광고 영역  ┃
                      // ┗━━━━━━━━━━━━━┛
                      _bannerAd == null && _bannerIsLoaded
                          ? Container()
                          // 계정 광고 제거 결재 체크
                          : APIs.me.adNotShow
                              ? Container()
                              : Container(
                                  color: Colors.white,
                                  width: mq.width,
                                  height: mq.height * .07,
                                  child: Center(
                                    child: Container(
                                      width: mq.width * .9,
                                      color: Colors.white,
                                      child: AdWidget(
                                        ad: _bannerAd!,
                                      ),
                                    ),
                                  )),
                      // ┏━━━━━━━━━━━━━━━━━━┓
                      // ┃  광고 하단 공백  ┃
                      // ┗━━━━━━━━━━━━━━━━━━┛
                      APIs.me.adNotShow
                          ? Container()
                          : Container(
                              color: Colors.white,
                              height: mq.height * .03,
                            )
                    ],
                  ),
                ),
              );
            } else {
              // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  기본 정보 미 등록시 기본 정보 등록 화면 으로 이동  ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
              return const InfoInsertScreen();
            }
          }
        });
  }
}
