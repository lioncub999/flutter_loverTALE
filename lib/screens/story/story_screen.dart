import 'package:flutter/material.dart';

import '../../main.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    print(mq.height);
    return Container(
      height: mq.height,
      color: Colors.blue,
    );
  }
}
