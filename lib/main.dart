import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_lover_tale/screens/common/splash_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                             앱 실행 메인 화면                              ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<초기화>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// 전영역 크기 관리 mq (Media Query) 초기화
late Size mq;
// 자주 사용 하는 색상 초기화
late Color baseWhite;
late Color greyColor;
late Color unselectGreyColor;
// asset Path
late String commonPath;
// Initialize-Firebase (firebase 초기화)
_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<초기화>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

void main() async {
  // WidgetFlutterBinding 인스턴스 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 카카오 로그인 네이티브 앱키
  String kakaoNativeAppKey = 'cb3fa92e586e1bf7092997e5a9a9d5be';
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

  // 구글 AdMob 초기화
  MobileAds.instance.initialize();

  // firebase 초기화
  await _initializeFirebase();

  runApp(MultiProvider(
    // 전역 변수 관리 (MainStore)
    providers: [
      ChangeNotifierProvider(create: (c) => MainStore()),
    ],
    child: MaterialApp(
      // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      // ┃   현지화 (언어 UI) 옵션   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', ''), // 한국어
        Locale('en', ''), // 영어
      ],
      // ┏━━━━━━━━━━━━━━━━━━━━━┓
      // ┃   전체 공통 Theme   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━┛
      theme: ThemeData(
        // GOOGLE Ripple Effect 비 활성화
        splashFactory: NoSplash.splashFactory,
        // 앱바 공통 Theme
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(245, 245, 245, 1),
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(109, 109, 109, 1),
              fontWeight: FontWeight.w700,
            ),
            iconTheme: IconThemeData(color: Color.fromRGBO(109, 109, 109, 1))),
        // 공통 폰트
        fontFamily: 'Pretendard',
      ),
      // ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
      // ┃   MaterialApp - home   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
      home: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// 전역 State <MainStore>
class MainStore extends ChangeNotifier {}

class _MyAppState extends State<MyApp> {
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  Widget build(BuildContext context) {
    // 전역 공통 변수 관리
    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━<전역 공통 변수 관리>━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    mq = MediaQuery.of(context).size;
    baseWhite = const Color.fromRGBO(245, 245, 245, 1);
    greyColor = const Color.fromRGBO(109, 109, 109, 1);
    unselectGreyColor = const Color.fromRGBO(197, 197, 197, 1);
    commonPath = 'assets/common';

    // 사이즈 요소 관련 디버그 모드
    debugPaintSizeEnabled = false;
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━<전역 공통 변수 관리>━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    // ┃   앱 실행시 스플레시 스크린으로 이동   ┃
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    return const Scaffold(
      body: Center(
        child: SplashScreen(),
      ),
    );
  }
}
