import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../apis/apis.dart';
import '../../helper/custom_dialogs.dart';
import '../../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                로그인 화면                                 ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 로그인 애니메이션 관리
  bool _isAnimate = false;

  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
    // 0.5 초 Duration 으로 애니메이션
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   로그인 버튼 클릭   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━┛
  _handleLoginBtnClick() {
    // 로딩 시작
    CustomDialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      Navigator.pop(context); // 로딩 끝
      if (user != null) {
        print(user);
        // DB에 로그인 정보 확인
        // if ((await APIs.userExists())) {
        //   // DB에 정보 있으면 홈 화면으로 이동
        //   Navigator.pushAndRemoveUntil(
        //       context, MaterialPageRoute(builder: (_) => const Text('aa')), (route) => false);
        //   CustomDialogs.showSnackbar(context, '로그인 되었습니다');
        //
        // }
        // db에 로그인 정보 없으면 데이터 create
        // else {
        //   APIs.createUser().then((value) {
        //     Navigator.pushAndRemoveUntil(
        //         context, MaterialPageRoute(builder: (_) => const Text('aa')), (route) => false);
        //     CustomDialogs.showSnackbar(context, '로그인 되었습니다');
        //   });
        // }
      }
    });
  }

  // ┏━━━━━━━━━━━━━━━━━┓
  // ┃   구글 로그인   ┃
  // ┗━━━━━━━━━━━━━━━━━┛
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 56, 60, 1), // Splash Screen backgroundColor
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .4 : mq.height * .6,
              right: mq.width * 0.35,
              width: mq.width * 0.5,
              child: Text("Lover", style: TextStyle(color: Colors.white, fontSize: 30))),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .45 : mq.height * .65,
              right: _isAnimate ? mq.width * 0.25 : mq.width * .25,
              width: mq.width * 0.5,
              child: Text("TALE", style: TextStyle(color: Colors.white, fontSize: 30))),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            top: mq.height * .7,
            left: _isAnimate ? mq.width * .05 : mq.width * 1,
            child:
                // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                // ┃  Body - 애플 로그인 버튼    ┃
                // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                SizedBox(
                    width: mq.width * 0.9,
                    height: mq.height * 0.06,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Btn-BackgroundColor
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))), // Btn-Shape
                        ),
                        onPressed: () {
                          // _handleLoginBtnClick(); // LoginBtn-ClickEvent
                        },
                        // LoginBtn-Element
                        label: RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              children: [
                                TextSpan(text: '애플 아이디로 '),
                                TextSpan(text: '로그인', style: TextStyle(fontWeight: FontWeight.w500))
                              ]),
                        ))),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            top: mq.height * .78,
            left: _isAnimate ? mq.width * .05 : mq.width * 1,
            child:
            // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
            // ┃  Body - 카카오 로그인 버튼    ┃
            // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
            SizedBox(
                width: mq.width * 0.9,
                height: mq.height * 0.06,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Btn-BackgroundColor
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))), // Btn-Shape
                    ),
                    onPressed: () {
                      // _handleLoginBtnClick(); // LoginBtn-ClickEvent
                    },
                    // LoginBtn-Element
                    label: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(text: '카카오 아이디로 '),
                            TextSpan(text: '로그인', style: TextStyle(fontWeight: FontWeight.w500))
                          ]),
                    ))),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            top: mq.height * .86,
            left: _isAnimate ? mq.width * .05 : mq.width * 1,
            child:
            // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
            // ┃  Body - 구글 로그인 버튼    ┃
            // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
            SizedBox(
                width: mq.width * 0.9,
                height: mq.height * 0.06,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Btn-BackgroundColor
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))), // Btn-Shape
                    ),
                    onPressed: () {
                      _handleLoginBtnClick(); // LoginBtn-ClickEvent
                    },
                    // LoginBtn-Element
                    label: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(text: '구글 아이디로 '),
                            TextSpan(text: '로그인', style: TextStyle(fontWeight: FontWeight.w500))
                          ]),
                    ))),
          )
        ],
      ),
    );
  }
}
