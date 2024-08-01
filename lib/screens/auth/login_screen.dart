import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../apis/apis.dart';
import '../../helper/custom_dialogs.dart';
import '../../main.dart';
import '../home_screen.dart';

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
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
            CustomDialogs.showSnackbar(context, '로그인 되었습니다');
          }
        });
      case 'KAKAO':
        _signInWithKakao().then((user) async {
          // 로딩 끝
          Navigator.pop(context);
          if (user != null) {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
            CustomDialogs.showSnackbar(context, '로그인 되었습니다');
          }
        });
      case 'GOOGLE':
        _signInWithGoogle().then((user) async {
          // 로딩 끝
          Navigator.pop(context);
          if (user != null) {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
            CustomDialogs.showSnackbar(context, '로그인 되었습니다');
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
      // OAuthCredential로 변환
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      // Firebase에 자격 증명으로 로그인
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e) {
      print("Error during Apple Sign-In: $e");
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
        // 카카오 로그인에서 발급된 idToken(카카오 설정에서 OpenID Connect가 활성화 되어있어야함)
        accessToken: token.accessToken, // 카카오 로그인에서 발급된 accessToken
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 56, 60, 1), // Splash Screen backgroundColor
      body: Stack(
        children: [
          // Login Screen Title - "Lover"
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .4 : mq.height * .6,
              right: mq.width * 0.35,
              width: mq.width * 0.5,
              child: Text("Lover", style: TextStyle(color: Colors.white, fontSize: 30))),
          // Login Screen Title - "TALE"
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _isAnimate ? mq.height * .45 : mq.height * .65,
              right: _isAnimate ? mq.width * 0.25 : mq.width * .25,
              width: mq.width * 0.5,
              child: Text("TALE", style: TextStyle(color: Colors.white, fontSize: 30))),
          // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
          // ┃  Body - 애플 로그인 버튼    ┃
          // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            top: mq.height * .7,
            left: _isAnimate ? mq.width * .05 : mq.width * 1,
            child:
            SizedBox(
                width: mq.width * 0.9,
                height: mq.height * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    await _signInWithKakao();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/apple_logo.png', // 카카오 로고 이미지 경로
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '애플 아이디로 로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
          // ┃  Body - 카카오 로그인 버튼    ┃
          // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            top: mq.height * .78,
            left: _isAnimate ? mq.width * .05 : mq.width * 1,
            child:
                SizedBox(
                    width: mq.width * 0.9,
                    height: mq.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _signInWithKakao();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(252, 215, 50, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/kakao_logo.png', // 카카오 로고 이미지 경로
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '카카오 아이디로 로그인',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
          ),
          // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
          // ┃  Body - 구글 로그인 버튼    ┃
          // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            top: mq.height * .86,
            left: _isAnimate ? mq.width * .05 : mq.width * 1,
            child:
                SizedBox(
                    width: mq.width * 0.9,
                    height: mq.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _signInWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google_logo.png', // 구글 로고 이미지 경로
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '구글 아이디로 로그인',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
