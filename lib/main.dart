import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_lover_tale/screens/common/splash_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                             앱 실행 메인 화면                              ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

// 전영역 크기 관리 mq (Media Query) 초기화
late Size mq;
// 색상
late Color whiteColor;
late Color greyColor;
late Color unselectGreyColor;

// asset path
late String commonPath;

// Initialize-Firebase (firebase 초기화)
_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  // 카카오 로그인 네이티브 앱키
  String kakaoNativeAppKey = 'cb3fa92e586e1bf7092997e5a9a9d5be';
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

  // WidgetFlutterBinding 인스턴스 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // firebase 초기화
  await _initializeFirebase();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => MainStore()),
    ],
    child: MaterialApp(
      // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      // ┃   현지화 (언어 UI) 옵션   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // Material Design 위젯 현지화
        GlobalWidgetsLocalizations.delegate, // 일반 Flutter 위젯 현지화
        GlobalCupertinoLocalizations.delegate, // Cupertino 위젯 현지화
      ],
      // 지원 언어 및 지역
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
                fontSize: 20,
              ),
              iconTheme: IconThemeData(color: Color.fromRGBO(109, 109, 109, 1))),
          // 공통 폰트
          fontFamily: 'Pretendard'),
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
  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  Widget build(BuildContext context) {
    // 전역 공통 변수 관리
    mq = MediaQuery.of(context).size;
    whiteColor = const Color.fromRGBO(245, 245, 245, 1);
    greyColor = const Color.fromRGBO(109, 109, 109, 1);
    unselectGreyColor = const Color.fromRGBO(197, 197, 197, 1);
    commonPath = 'assets/common/';
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
