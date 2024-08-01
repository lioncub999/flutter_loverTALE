import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/auth/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../apis/apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("안녕하세요")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 비동기 작업 2: Firebase 로그아웃
          await APIs.auth.signOut();
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);

        },
      ),
    );
  }
}
