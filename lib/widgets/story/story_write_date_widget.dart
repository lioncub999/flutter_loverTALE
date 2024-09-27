import 'package:flutter/material.dart';

import '../../helper/custom_date_util.dart';
import '../../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                             ┃
// ┃                          이야기 작성 날짜 카드 위젯                         ┃
// ┃                                                                             ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

class StoryWriteDateWidget extends StatefulWidget {
  const StoryWriteDateWidget({super.key, required this.diffType, required this.hour});

  final String diffType;
  final int hour;

  @override
  State<StoryWriteDateWidget> createState() => _StoryWriteDateWidgetState();
}

class _StoryWriteDateWidgetState extends State<StoryWriteDateWidget> {
  @override
  Widget build(BuildContext context) {
    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆위젯★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .01),
      width: mq.width * .15,
      height: mq.height * .15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("", style: TextStyle(fontSize: mq.width * .035, height: mq.width * .007, color: orangeColor, fontWeight: FontWeight.w800)),
          Text("", style: TextStyle(fontSize: mq.width * .01)),
          widget.diffType == "subtract"
              ? Text(DateTime.now().subtract(Duration(hours: widget.hour)).day.toString(),
                  style: TextStyle(fontSize: mq.width * .08, height: mq.width * .003, color: Colors.white, fontWeight: FontWeight.w500))
              : Text(DateTime.now().add(Duration(hours: widget.hour)).day.toString(),
                  style: TextStyle(fontSize: mq.width * .08, height: mq.width * .003, color: Colors.white, fontWeight: FontWeight.w500)),
          widget.diffType == "subtract"
              ? Text(CustomDateUtil.calculateWeekName(DateTime.now().subtract(Duration(hours: widget.hour))),
                  style: TextStyle(fontSize: mq.width * .05, height: mq.width * .002, color: Colors.white, fontWeight: FontWeight.w500))
              : Text(CustomDateUtil.calculateWeekName(DateTime.now().add(Duration(hours: widget.hour))),
                  style: TextStyle(fontSize: mq.width * .05, height: mq.width * .002, color: Colors.white, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
