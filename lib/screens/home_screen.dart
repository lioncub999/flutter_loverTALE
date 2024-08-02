import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/screens/auth/info_insert_screen.dart';
import 'package:flutter_lover_tale/screens/auth/login_screen.dart';

import '../apis/apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: APIs.getSelfInfo(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      else {
        if (APIs.me.isDefaultInfoSet && APIs.me.gender.isNotEmpty) {
          return Scaffold(
            body: const Center(child: Text("안녕하세요")),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // 비동기 작업 2: Firebase 로그아웃
                await APIs.auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
              },
            ),
          );
        } else {
          return const InfoInsertScreen();
        }
      }
    });
  }
}
