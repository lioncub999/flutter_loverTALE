import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/initial/info_insert_screen.dart';
import 'package:flutter_lover_tale/screens/auth/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../apis/apis.dart';
import '../main.dart';
import 'initial/sign_couple_screen.dart';

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
  bool isScrollable = false;
  bool showNextIcon = false;
  bool showBackIcon = false;

  List<TabData> tabs = [
    TabData(
      index: 1,
      title: const Tab(
        child: Text('홈'),
      ),
      content: Container(
        color: const Color.fromRGBO(245, 245, 245, 1),
      ),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('이야기'),
      ),
      content: const Center(child: Text('Content for Tab 2')),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('추억지도'),
      ),
      content: const Center(child: Text('Content for Tab 2')),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('내정보'),
      ),
      content: const Center(child: Text('Content for Tab 2')),
    ),
    // Add more tabs as needed
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
        future: APIs.getSelfInfo(),
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
                appBar: AppBar(
                  leading: Container(
                    padding: const EdgeInsets.all(8.0), // 필요한 만큼의 패딩을 추가
                    alignment: Alignment.center, // 로고를 가운데로 정렬
                    child: SvgPicture.asset(
                      'assets/logo/lover_tale_logo.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                  title: const Text("홈"),
                  actions: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz))
                  ],
                ),
                body: SizedBox(
                  width: mq.width,
                  height: mq.height,
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
                         onTabControllerUpdated: (controller) {
                         },
                         onTabChanged: (index) {
                         },
                         onAddTabMoveTo: MoveToTab.last,
                         showBackIcon: showBackIcon,
                         showNextIcon: showNextIcon,
                       ),
                     ),
                   ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: const Text("로그아웃임시"),
                  onPressed: () async {
                    // 비동기 작업 2: Firebase 로그아웃
                    await APIs.auth.signOut();
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                  },
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
