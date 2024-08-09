import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/histmap/hist_map_screen.dart';
import 'package:flutter_lover_tale/screens/initial/info_insert_screen.dart';
import 'package:flutter_lover_tale/screens/auth/login_screen.dart';
import 'package:flutter_lover_tale/screens/mypage/mypage_screen.dart';
import 'package:flutter_lover_tale/screens/story/story_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../apis/apis.dart';
import '../apis/user_apis.dart';
import '../main.dart';
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
  @override
  void initState() {
    super.initState();
  }


  // Tap 관리 State
  bool isScrollable = false;
  bool showNextIcon = false;
  bool showBackIcon = false;

  // 탭 안에 들어갈 내용
  List<TabData> tabs = [
    TabData(
        index: 1,
        title: const Tab(
          child: Text('     홈     '),
        ),
        content: const MainScreen()),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('  이야기  '),
      ),
      content: const StoryScreen(),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('추억지도'),
      ),
      content: const HistMapScreen(),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('  내정보  '),
      ),
      content: const MypageScreen(),
    ),
  ];

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
              body: Center(child: CircularProgressIndicator()),
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
            // ┏━━━━━━━━━━━━━━━━━━━━━━┓
            // ┃  기본정보 등록 확인  ┃
            // ┗━━━━━━━━━━━━━━━━━━━━━━┛
            if (APIs.me.gender.isNotEmpty && APIs.me.birthDay.isNotEmpty) {
              return Scaffold(
                // ┏━━━━━━━━━━━━┓
                // ┃   AppBar   ┃
                // ┗━━━━━━━━━━━━┛
                appBar: AppBar(
                  // AppBar - Leading
                  leading: Container(
                    padding: const EdgeInsets.all(8.0), // 필요한 만큼의 패딩을 추가
                    alignment: Alignment.center, // 로고를 가운데로 정렬
                    child: SvgPicture.asset(
                      'assets/logo/lover_tale_logo.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                  // AppBar - Title
                  title: const Text("홈"),
                  // AppBar - Action
                  actions: [
                    IconButton(
                        onPressed: () async {
                          // 비동기 작업 2: Firebase 로그아웃 임시
                          await APIs.auth.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (route) => false);
                        },
                        icon: const Icon(Icons.more_horiz))
                  ],
                ),
                // ┏━━━━━━━━━━━━━━━━━━━━━━━┓
                // ┃   Body - Tap + 화면   ┃
                // ┗━━━━━━━━━━━━━━━━━━━━━━━┛
                body: Container(
                  color: const Color.fromRGBO(245, 245, 245, 1),
                  width: mq.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: DynamicTabBarWidget(
                          dividerHeight: 0,
                          labelColor: const Color.fromRGBO(109, 109, 109, 1),
                          unselectedLabelColor: const Color.fromRGBO(197, 197, 197, 1),
                          indicatorColor: const Color.fromRGBO(109, 109, 109, 1),
                          dynamicTabs: tabs,
                          isScrollable: isScrollable,
                          onTabControllerUpdated: (controller) {},
                          onTabChanged: (index) {},
                          onAddTabMoveTo: MoveToTab.last,
                          showBackIcon: showBackIcon,
                          showNextIcon: showNextIcon,
                        ),
                      ),
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
