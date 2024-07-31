import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

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
        // // DB에 로그인 정보 확인
        // if ((await APIs.userExists())) {
        //   // DB에 정보 있으면 홈 화면으로 이동
        //   Navigator.pushAndRemoveUntil(
        //       context, MaterialPageRoute(builder: (_) => const Text('aa')), (route) => false);
        //   CustomDialogs.showSnackbar(context, '로그인 되었습니다');
        //
        // }
        // // db에 로그인 정보 없으면 데이터 create
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

  Future<UserCredential?> signInWithKakao() async {
    // try {
    //   bool isInstalled = await isKakaoTalkInstalled();
    //
    //   print(isInstalled);
    //
    //   OAuthToken token = isInstalled
    //       ? await UserApi.instance.loginWithKakaoTalk()
    //       : await UserApi.instance.loginWithKakaoAccount();
    //
    //   // Firebase 자격 증명으로 변환
    //   final oauthCredential = OAuthProvider("oidc.lovertale").credential(
    //     accessToken: token.accessToken,
    //   );
    //
    //   // 사용자 정보 가져오기
    //   final url = Uri.https('kapi.kakao.com', '/v2/user/me');
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
    //     },
    //   );
    //
    //   final profileInfo = json.decode(response.body);
    //
    //   // Firebase에 자격 증명으로 로그인
    //   return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    //
    // } catch (error) {
    //   print('카카오톡으로 로그인 실패 $error');
    //   return null;
    // }
    try {
      OAuthToken token =
      await UserApi.instance.loginWithKakaoAccount(); // 카카오 로그인
      var provider = OAuthProvider('oidc.lovertale'); // 제공업체 id
      var credential = provider.credential(
        idToken: token.idToken,
        // 카카오 로그인에서 발급된 idToken(카카오 설정에서 OpenID Connect가 활성화 되어있어야함)
        accessToken: token.accessToken, // 카카오 로그인에서 발급된 accessToken
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
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
                    child: SignInWithAppleButton(
                      onPressed: () async {
                        await _signInWithApple();
                        print(APIs.user);
                      },
                    )),
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
                          signInWithKakao();
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
