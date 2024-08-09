import 'package:flutter/material.dart';

class HistMapScreen extends StatefulWidget {
  const HistMapScreen({super.key});

  @override
  State<HistMapScreen> createState() => _HistMapScreenState();
}

class _HistMapScreenState extends State<HistMapScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("추억 지도 화면"),
    );
  }
}
