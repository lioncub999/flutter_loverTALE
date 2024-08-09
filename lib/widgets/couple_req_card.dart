import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/helper/custom_date_util.dart';
import 'package:flutter_lover_tale/models/user_model.dart';

import '../models/couple_request_model.dart';
import 'couple_req_dialog.dart';

class CoupleReqCard extends StatefulWidget {
  const CoupleReqCard({super.key, required this.user, required this.req});

  final ModuUser user;
  final CoupleReq  req;

  @override
  State<CoupleReqCard> createState() => _CoupleReqCardState();
}

class _CoupleReqCardState extends State<CoupleReqCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (_) => CoupleReqDialog(user : widget.user, req: widget.req));
        },
        child: ListTile(
          leading: widget.user.gender == 'M' ? Icon(Icons.male) : Icon(Icons.female),
          title: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text(widget.user.name),
                    ],
                  ),
                ),
                Text("(${CustomDateUtil.getOrgTime(context: context, date: widget.user.birthDay, returnType: 'korYMD')})")
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
