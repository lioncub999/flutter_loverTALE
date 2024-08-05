import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';

import '../../apis/apis.dart';
import '../../main.dart';
import '../auth/login_screen.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                              스플레시 화면                                 ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
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
          Navigator.of(context).pushReplacement(_moveLoginRoute());
        }
      });
  }


  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃  LoginScreen 이동 페이지 Blur ROUTE  ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  Route _moveLoginRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
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

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1), // Splash Screen backgroundColor
        // ┏━━━━━━━━┓
        // ┃  Body  ┃
        // ┗━━━━━━━━┛
        body:Center(
          child: SizedBox(
            width: mq.width,
            height: mq.height * .5,
            child: Image.asset('assets/splash.png'),
          ),
        )
    );
  }
}
