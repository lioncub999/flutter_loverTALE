import 'package:flutter/material.dart';

import '../initial/couple/sign_couple_screen.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignCoupleScreen()));
      }, child: const Text("커플 등록")),
    );
  }
}
