import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';

import '../../../main.dart';
import '../../apis/apis.dart';
import '../auth/info_insert_screen.dart';
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
    // 애니메이션 1초후 시작
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isAnimate = true;
      });
    });
    // "milliseconds : 2초" 후 로그인 화면 이동
    Future.delayed(const Duration(milliseconds: 2000), () {
      // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      // ┃   로그인된 유저 있으면 HomeScreen 이동   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      if (APIs.auth.currentUser != null) {
        Navigator.of(context).pushReplacement(_moveHomeRoute());
      }
      // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      // ┃   로그인 안되어 있으면 LoginScreen 이동   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      else {
        Route createRoute() {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },
          );
        }
        Navigator.of(context).push(createRoute());
      }
    });
  }
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃  HomeScreen 이동 페이지 Blur ROUTE   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  Route _moveHomeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0 * animation.value,
                sigmaY: 10.0 * animation.value,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.1 * animation.value),
              ),
            ),
            FadeTransition(
              opacity: animation,
              child: child,
            ),
          ],
        );
      },
    );
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
          // Splash Screen Title - "Lover"
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .6 : mq.height * 1,
              right: mq.width * 0.35,
              width: mq.width * 0.5,
              child: const Text("Lover", style: TextStyle(color: Colors.white, fontSize: 30))),
          // Splash Screen Title - "TALE"
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .65 : mq.height * 1,
              right: _isAnimate ? mq.width * 0.25 : mq.width * .05,
              width: mq.width * 0.5,
              child: const Text("TALE", style: TextStyle(color: Colors.white, fontSize: 30))),
        ],
      ),
    );
  }
}
