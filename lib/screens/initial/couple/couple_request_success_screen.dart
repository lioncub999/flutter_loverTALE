import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';
import 'package:flutter_lover_tale/screens/main/main_screen.dart';

class CoupleRequestSuccessScreen extends StatefulWidget {
  const CoupleRequestSuccessScreen({super.key});

  @override
  State<CoupleRequestSuccessScreen> createState() => _CoupleRequestSuccessScreenState();
}


class _CoupleRequestSuccessScreenState extends State<CoupleRequestSuccessScreen> {
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(_moveHomeRoute());
            },
            child: Text(" 커플 신청이 완료되었습니다. "),
          ),
        ),
      ),
    );
  }
}
