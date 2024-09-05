import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/apis/couple_apis.dart';
import 'package:flutter_lover_tale/helper/custom_date_util.dart';
import 'package:flutter_lover_tale/models/couple_model.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';

import '../../main.dart';
import '../../models/user_model.dart';
import '../apis/user_apis.dart';

class CoupleReqDialog extends StatelessWidget {
  const CoupleReqDialog({super.key, required this.user, required this.req});

  final ModuUser user;
  final Couple req;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .35,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(mq.width * .25),
                child: Text('연애 시작일 '+CustomDateUtil.getOrgTime(context: context, date: req.loveStartDay, returnType: 'korYMD')),
              ),
            ),
            Positioned(
              left: mq.width * .04,
              top: mq.height * .02,
              width: mq.width * .55,
              child: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 6 ,
              child: ElevatedButton(
                onPressed: () async {
                  await CoupleAPIs.confirmCouple(req);
                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                child: const Text("asd"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
