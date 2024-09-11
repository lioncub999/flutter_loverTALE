import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/helper/custom_dialogs.dart';
import 'package:flutter_lover_tale/helper/custom_page_control.dart';
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
        Navigator.of(context).pushReplacement(CustomPageControl.movePageBlur(const HomeScreen()));
      }
      // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      // ┃   로그인 안되어 있으면 LoginScreen 이동   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      else {
        Navigator.of(context).pushReplacement(CustomPageControl.movePageBlur(const LoginScreen()));
      }
    });
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: baseWhite,
        // ┏━━━━━━━━┓
        // ┃  Body  ┃
        // ┗━━━━━━━━┛
        body: Center(
          child: SizedBox(
            width: mq.width,
            height: mq.height * .5,
            child: Image.asset('assets/splash.png'),
          ),
        ));
  }
}
