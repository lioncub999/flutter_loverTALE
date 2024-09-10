import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/apis/couple_apis.dart';
import 'package:flutter_lover_tale/helper/custom_date_util.dart';
import 'package:flutter_lover_tale/helper/custom_dialogs.dart';
import 'package:flutter_lover_tale/models/user_model.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';
import 'package:flutter_lover_tale/screens/initial/couple/couple_request_success_screen.dart';
import 'package:flutter_svg/svg.dart';

import '../../../apis/apis.dart';
import '../../../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                               커플 등록 화면                               ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class SignCoupleScreen extends StatefulWidget {
  const SignCoupleScreen({super.key});

  @override
  State<SignCoupleScreen> createState() => _SignCoupleScreenState();
}

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
// ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
// ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class _SignCoupleScreenState extends State<SignCoupleScreen> {
  // 포커스 노드
  final FocusNode _focusNode = FocusNode();

  // 채팅창 TextField 컨트롤러
  final _textController = TextEditingController();

  late bool _isDateSelected = false;
  DateTime _selectedDate = DateTime.now();
  String _stringSelectedDate = "";

  // ┏━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   포커스 노드 제거   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

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
                  _stringSelectedDate =
                      CustomDateUtil.getOrgTime(context: context, date: _selectedDate.millisecondsSinceEpoch.toString(), returnType: "onlyMiddleBar");
                });
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // ┏━━━━━━━━━━┓
        // ┃  AppBar  ┃
        // ┗━━━━━━━━━━┛
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                elevation: WidgetStateProperty.all(0),
              ),
              onPressed: () async {},
              child: Text(
                "나의 코드 복사하기",
                style: TextStyle(color: greyColor, fontWeight: FontWeight.w800, fontSize: mq.width * .04),
              ),
            )
          ],
        ),
        // ┏━━━━━━━━┓
        // ┃  Body  ┃
        // ┗━━━━━━━━┛
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _focusNode.unfocus();
          },
          child: SizedBox(
            width: mq.width,
            height: mq.height,
            child: Column(
              children: [
                SizedBox(
                  width: mq.width,
                  height: mq.height * .2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mq.width * .05,
                      ),
                      Container(
                        width: mq.width * .55,
                        child: Image.asset("$commonPath/text/couple_sign_text.png"),
                      ),
                      Container(
                        width: mq.width * .4,
                        child: Image.asset("$commonPath/character/girl_right.png"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: mq.width * .75,
                      child: Text(
                        "내 코드",
                        style: TextStyle(color: greyColor, fontSize: mq.width * .06, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: mq.width * .05,
                    ),
                  ],
                ),
                SizedBox(
                  width: mq.width * .8,
                  height: mq.height * .05,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(246, 246, 246, 1),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          APIs.me.userCode,
                          style: TextStyle(fontSize: mq.width * .035, letterSpacing: -0.24, color: greyColor),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: mq.width * .75,
                      child: Text(
                        "상대방 코드 등록하기",
                        style: TextStyle(color: greyColor, fontSize: mq.width * .06, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: mq.width * .05,
                    ),
                  ],
                ),
                Card(
                  elevation: 0,
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width: mq.width * .8,
                    height: mq.height * .05,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(fontSize: mq.width * .035, letterSpacing: -0.24, color: greyColor),
                            decoration: InputDecoration(
                              hintText: '상대방 코드를 입력하세요',
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: mq.width * .06),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: mq.width * .45,
                      child: Text(
                        "우리가 만난 날",
                        style: TextStyle(color: greyColor, fontSize: mq.width * .06, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: mq.width * .35,
                      height: mq.height * .05,
                      child: GestureDetector(
                        onTap: () => _showCupertinoDatePicker(context),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromRGBO(246, 246, 246, 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: mq.width * .01,
                                )
                                ,
                                SizedBox(
                                  width: mq.width * .25,
                                  child: _isDateSelected
                                      ? Center(
                                          child: Text(
                                            _stringSelectedDate,
                                            style: TextStyle(fontSize: mq.width * .035, color: greyColor),
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            '날짜 선택',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: const Color.fromRGBO(109, 109, 109, 1),
                                                fontSize: mq.width * .035),
                                          ),
                                        ),
                                ),
                                SvgPicture.asset(
                                  'assets/common/arrowBottom.svg',
                                  width: mq.width * .07,
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      ModuUser partner = ModuUser(
                        id: '',
                        name: '',
                        gender: '',
                        birthDay: '',
                        image: '',
                        createdAt: '',
                        email: '',
                        pushToken: '',
                        coupleId: '',
                        userCode: _textController.text,
                      );
                      if (_textController.text == APIs.me.userCode) {
                        CustomDialogs.showSnackbar(context, "나에게 보낼 수는 없어요~.~.");
                      } else {
                        if (await CoupleAPIs.checkUserCouple(partner)) {
                          await CoupleAPIs.sendCoupleRequest(partner, _selectedDate);
                          CustomDialogs.showSnackbar(context, "요청이 전송 되었습니다.");
                          await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CoupleRequestSuccessScreen()));
                        } else {
                          CustomDialogs.showSnackbar(context, "코드를 확인 해주세요");
                        }
                      }
                    },
                    child: const Text("요청 보내기"))
              ],
            ),
          ),
        ));
  }
}
