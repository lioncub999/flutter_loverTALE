import 'dart:async';
import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../apis/apis.dart';
import '../../apis/user_apis.dart';
import '../../helper/custom_dialogs.dart';
import '../../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                                로그인 화면                                 ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  // 애니메이션 관리 state
  bool _isAnimate = false;

  // D-day + 관련 TIMER
  late Timer _periodicTimer;
  late Timer _stopTimer;

  // D-day opacity 처리
  late AnimationController _controller;
  late Animation<double> _animation;

  // D-day initialize
  int _dayCount = 1;

  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
    // D-Day + 시작
    _startTimer();

    // D-Day Opacity 1 -> 0 5초
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // D-day Opacity 애니메이션 시작
    _controller.forward();
    // 1.5 초 Duration 으로 애니메이션
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  void _startTimer() {
    // 100밀리초 간격으로 함수 실행
    _periodicTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _executeFunction();
    });

    // 5초 후에 타이머 종료
    _stopTimer = Timer(const Duration(seconds: 5), () {
      _periodicTimer.cancel();
    });
  }

  // _dayCount +1
  void _executeFunction() {
    setState(() {
      _dayCount += 1;
    });
  }

  // ┏━━━━━━━━━━━━━┓
  // ┃   dispose   ┃
  // ┗━━━━━━━━━━━━━┛
  @override
  void dispose() {
    _controller.dispose();
    _periodicTimer.cancel();
    _stopTimer.cancel();
    super.dispose();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   로그인 버튼 클릭   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━┛
  _handleLoginBtnClick(String platform) {
    // 로딩 시작
    CustomDialogs.showProgressBar(context);

    // 로그인 플랫폼별 로그인 방식 나누기
    switch (platform) {
      case 'APPLE':
        _signInWithApple().then((user) async {
          // 로딩 끝
          Navigator.pop(context);
          if (user != null) {
            await _checkUserExist();
          }
        });
      case 'KAKAO':
        _signInWithKakao().then((user) async {
          // 로딩 끝
          Navigator.pop(context);
          if (user != null) {
            await _checkUserExist();
          }
        });
      case 'GOOGLE':
        _signInWithGoogle().then((user) async {
          // 로딩 끝
          Navigator.pop(context);
          if (user != null) {
            await _checkUserExist();
          }
        });
    }
  }

  // ┏━━━━━━━━━━━━━━━━━┓
  // ┃   애플 로그인   ┃
  // ┗━━━━━━━━━━━━━━━━━┛
  Future<UserCredential?> _signInWithApple() async {
    try {
      // 애플 ID 자격 증명 얻기
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // OAuthCredential 변환
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      // Firebase에 자격 증명으로 로그인
      return await APIs.auth.signInWithCredential(oauthCredential);
    } catch (e) {
      return null;
    }
  }

  // ┏━━━━━━━━━━━━━━━━━━━┓
  // ┃   카카오 로그인   ┃
  // ┗━━━━━━━━━━━━━━━━━━━┛
  Future<UserCredential?> _signInWithKakao() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount(); // 카카오 로그인
      var provider = OAuthProvider('oidc.lovertale'); // 제공업체 id
      var credential = provider.credential(
        idToken: token.idToken,
        // 카카오 로그인에서 발급된 idToken(카카오 설정에서 OpenID Connect 활성화 되어있어야함)
        accessToken: token.accessToken, // 카카오 로그인에서 발급된 accessToken
      );
      return APIs.auth.signInWithCredential(credential);
    } catch (error) {
      return null;
    }
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

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   로그인 정보 확인 후 DB에 있는지 확인 (없으면 INSERT)   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  _checkUserExist() async {
    if (await UserAPIs.userExists()) {
      // true : db에 데이터 있음.
      await UserAPIs.logLoginHist();
      Navigator.of(context).pushReplacement(_moveHomeRoute());
    } else {
      UserAPIs.createUser().then((value) async {
        await UserAPIs.logLoginHist();
        Navigator.of(context).pushReplacement(_moveHomeRoute());
      });
    }
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
      backgroundColor: whiteColor, // Login Screen backgroundColor
      // ┏━━━━━━━━┓
      // ┃  Body  ┃
      // ┗━━━━━━━━┛
      body: Stack(
        children: [
          // Login Screen Title - D-Day
          Positioned(
            top: mq.height * .1,
            child: SizedBox(
              width: mq.width,
              child: Center(
                child: Opacity(
                  opacity: _animation.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // D-Day - Text - "D+"
                      Text(
                        "D+",
                        style: TextStyle(
                            color: const Color.fromRGBO(209, 209, 209, .4),
                            fontSize: mq.width * .25,
                            fontWeight: FontWeight.bold),
                      ),
                      // D-Day - Text - NUMBER
                      AnimatedFlipCounter(
                        value: _dayCount,
                        textStyle: TextStyle(
                            fontSize: mq.width * .25,
                            color: const Color.fromRGBO(209, 209, 209, .4),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Login Screen Title - 로고 이미지
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            top: _isAnimate ? mq.height * .15 : mq.height * -.5,
            child: SizedBox(
              width: mq.width,
              child: Center(
                child: Image.asset(
                  'assets/common/logo.png',
                  width: mq.width * .5,
                ),
              ),
            ),
          ),
          // Login Screen Title - "함께 러버테일에 로그인해 주세요(통 이미지)"
          Positioned(
            left: mq.width * .07,
            top: mq.height * .35,
            child: Image.asset(
              '$commonPath/loginTitle.png',
              width: mq.width * .8,
            ),
          ),
          // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
          // ┃  Body - 애플 로그인 버튼    ┃
          // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
          Positioned(
            top: mq.height * .7,
            left: mq.width * .05,
            child: SizedBox(
                width: mq.width * 0.9,
                height: mq.height * 0.06,
                child: _customLoginButton("APPLE")),
          ),
          // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
          // ┃  Body - 카카오 로그인 버튼    ┃
          // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
          Positioned(
            top: mq.height * .78,
            left: mq.width * .05,
            child: SizedBox(
                width: mq.width * 0.9,
                height: mq.height * 0.06,
                child: _customLoginButton("KAKAO")),
          ),
          // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
          // ┃  Body - 구글 로그인 버튼    ┃
          // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
          Positioned(
            top: mq.height * .86,
            left: mq.width * .05,
            child: SizedBox(
                width: mq.width * 0.9,
                height: mq.height * 0.06,
                child: _customLoginButton("GOOGLE")),
          )
        ],
      ),
    );
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃  커스텀 로그인 버튼    ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
  Widget _customLoginButton(String platform) {
    return ElevatedButton(
      onPressed: () async {
        await _handleLoginBtnClick(platform);
      },
      style: ElevatedButton.styleFrom(
        // BackgroundColor
        backgroundColor: platform == "APPLE"
            ? const Color.fromRGBO(0, 0, 0, 1.0)
            : platform == "KAKAO"
                ? const Color.fromRGBO(252, 215, 50, 1.0)
                : platform == "GOOGLE"
                    ? const Color.fromRGBO(245, 245, 245, 1.0)
                    : const Color.fromRGBO(245, 245, 245, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05, vertical: mq.height * .01),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 로고 이미지
          Image.asset(
            platform == "APPLE"
                ? 'assets/common/logo/apple_logo.png'
                : platform == "KAKAO"
                    ? 'assets/common/logo/kakao_logo.png'
                    : platform == "GOOGLE"
                        ? 'assets/common/logo/google_logo.png'
                        : 'assets/common/logo/apple_logo.png',
            height: 24,
          ),
          SizedBox(width: mq.width * .07),
          // 텍스트
          Text(
            platform == "APPLE"
                ? '애플 아이디로 로그인'
                : platform == "KAKAO"
                    ? '카카오 아이디로 로그인'
                    : platform == "GOOGLE"
                        ? '구글 아이디로 로그인'
                        : '애플 아이디로 로그인',
            // 텍스트 스타일
            style: TextStyle(
              color: platform == "APPLE"
                  ? Colors.white
                  : platform == "KAKAO"
                      ? Colors.black
                      : platform == "GOOGLE"
                          ? Colors.black
                          : Colors.black,
              fontSize: mq.width * .043,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
