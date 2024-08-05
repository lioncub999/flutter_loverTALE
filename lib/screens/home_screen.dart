import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/initial/info_insert_screen.dart';
import 'package:flutter_lover_tale/screens/auth/login_screen.dart';

import '../apis/apis.dart';
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
            return const Center(child: CircularProgressIndicator());
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
            if (APIs.me.isDefaultInfoSet &&
                APIs.me.gender!.isNotEmpty &&
                APIs.me.birthDay.isNotEmpty) {
              // ┏━━━━━━━━━━━━━━━━━━┓
              // ┃  커플 등록 확인  ┃
              // ┗━━━━━━━━━━━━━━━━━━┛
              if (APIs.me.partnerId.isNotEmpty) {
                return Scaffold(
                  body: const Center(child: Text("안녕하세요")),
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
                // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                // ┃  커플 미 등록시 커플 등록 화면 으로 이동  ┃
                // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                return const SignCoupleScreen();
              }
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
