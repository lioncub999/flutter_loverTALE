import 'dart:ui';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import '../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                  ┃
// ┃                                  CustomDialogs                                   ┃
// ┃                                                                                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class CustomDialogs {
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   msg 받아서 Toast 표시                                             ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static void showCustomToast(BuildContext context, String msg) {
    AnimatedSnackBar(
      builder: ((context) {
        return Container(
          width: mq.width * .5,
          height: mq.height * .05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mq.width * .25),
            color: const Color.fromRGBO(200, 226, 255, .7),
          ),
          child: Center(
            child: Text(
              msg,
              style: TextStyle(color: greyColor, fontSize: mq.width * .04),
            ),
          ),
        );
      }),
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      duration: const Duration(seconds: 1),
      mobilePositionSettings: MobilePositionSettings(
        bottomOnAppearance: mq.height * .21,
        bottomOnDissapear: mq.height * .18,
      ),
    ).show(context);
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   회전 로딩 화면 표시                                               ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static Future<void> showProgressBar(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        builder: (_) => const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ));
  }
}
