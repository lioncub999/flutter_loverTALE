import 'package:flutter/material.dart';

class InfoInsertScreen extends StatefulWidget {
  const InfoInsertScreen({super.key});

  @override
  State<InfoInsertScreen> createState() => _InfoInsertScreenState();
}

class _InfoInsertScreenState extends State<InfoInsertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 56, 60, 1), // InfoInsertScreen backgroundColor
      body: Center(
        child: Text("기본정보 입력 스크린", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
