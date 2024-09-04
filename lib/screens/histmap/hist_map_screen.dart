import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';

class HistMapScreen extends StatefulWidget {
  const HistMapScreen({super.key});

  @override
  State<HistMapScreen> createState() => _HistMapScreenState();
}

class _HistMapScreenState extends State<HistMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (context, index) {
        return Container(
          child: SvgPicture.asset('$commonPath/main/main_diary.svg',),
        );
      },
      onIndexChanged: (value) => {
        print(value)
      },
      itemCount: 2,
      loop: false,
      viewportFraction: .5,
      scale: .4,
      containerWidth: mq.width,
      fade: .1,

    );
  }
}
