import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../apis/apis.dart';
import '../auth/login_screen.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                              스플레시 화면                                 ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // 스플래시 화면 애니메이션 관리
  bool _isAnimate = false;
  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
    // 애니메이션
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isAnimate = true;
      });
    });
    // "milliseconds : x초" 후 로그인 화면 이동
    Future.delayed(const Duration(milliseconds: 2000), () {
      // 로그인된 유저 있으면 HomeScreen 이동
      if (APIs.auth.currentUser != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Text("로그인됨")));
      }
      // 로그인 안되어있으면 LoginScreen 이동
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }

      Route _createRoute() {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      }
      Navigator.of(context).push(_createRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 56, 60, 1), // Splash Screen backgroundColor
      // ┏━━━━━━━━┓
      // ┃  Body  ┃
      // ┗━━━━━━━━┛
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .6 : mq.height * 1,
              right: mq.width * 0.35,
              width: mq.width * 0.5,
              child: Text("Lover", style: TextStyle(color: Colors.white, fontSize: 30))),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .65 : mq.height * 1,
              right: _isAnimate ? mq.width * 0.25 : mq.width * .05,
              width: mq.width * 0.5,
              child: Text("TALE", style: TextStyle(color: Colors.white, fontSize: 30))),
        ],
      ),
    );
  }
}
