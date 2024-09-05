import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/helper/custom_date_util.dart';
import 'package:flutter_lover_tale/models/user_model.dart';

import '../models/couple_model.dart';
import 'couple_req_dialog.dart';

class CoupleReqCard extends StatefulWidget {
  const CoupleReqCard({super.key, required this.user, required this.req});

  final ModuUser user;
  final Couple  req;

  @override
  State<CoupleReqCard> createState() => _CoupleReqCardState();
}

class _CoupleReqCardState extends State<CoupleReqCard> {
  // 연애 시작일 선택
  late bool _isDateSelected = false;
  DateTime _selectedDate = DateTime.now();

// ┏━━━━━━━━━━━━━━━━━━━━━━┓
// ┃   ios 날짜 선택 UI   ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━┛
  void _showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SizedBox(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                  _isDateSelected = true;
                });
              },
            ),
          );
        });
  }

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
