import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lover_tale/helper/custom_date_util.dart';
import 'package:flutter_lover_tale/helper/custom_dialogs.dart';
import 'package:flutter_lover_tale/helper/custom_page_control.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../apis/apis.dart';
import '../../apis/user_apis.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../auth/login_screen.dart';
import '../home_screen.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                             ┃
// ┃                             기본 정보 입력 화면                             ┃
// ┃                                                                             ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class InfoInsertScreen extends StatefulWidget {
  const InfoInsertScreen({super.key});

  @override
  State<InfoInsertScreen> createState() => _InfoInsertScreenState();
}

class _InfoInsertScreenState extends State<InfoInsertScreen> {
  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   포커스 노드 제거   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // 성별 선택
  String _selectedGender = 'M';

  // 생일 선택
  bool _isDateSelected = false;
  DateTime _selectedDate = DateTime.now();

  // 포커스 노드
  final FocusNode _focusNode = FocusNode();

  // 채팅창 TextField 컨트롤러
  final _textController = TextEditingController(text: APIs.me.name);

  // 텍스트 필드 입력시 스테이트 업데이트
  void _onTextChanged() {
    setState(() {});
  }
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<Function>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  void _updateUserInfo() async {
    final birthDay = _selectedDate.millisecondsSinceEpoch.toString();
    ModuUser user = ModuUser(
      image: '',
      gender: _selectedGender == 0 ? 'M' : 'G',
      name: _textController.text,
      birthDay: birthDay,
      createdAt: '',
      id: '',
      email: '',
      pushToken: '',
      coupleId: '',
      userCode: '',
      adNotShow: false,
    );
    try {
      await UserAPIs.updateUserDefaultInfo(user);
      Navigator.pushReplacement(context, CustomPageControl.movePageBlur(const HomeScreen()));
    } catch (e) {
      rethrow;
    }
  }
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<Function>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

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
                print(_selectedDate);
                setState(() {
                  _selectedDate = newDate;
                  _isDateSelected = true;
                });
              },
            ),
          );
        });
  }

  // ┏━━━━━━━━━━━━━━━━━━━━┓
  // ┃   라디오 버튼 UI   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━┛
  Widget _buildCustomRadioButton(String text, String gender) {
    bool isSelected = _selectedGender == gender;
    return SizedBox(
      width: mq.width * .3,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedGender = gender;
          });
        },
        child: Row(
          children: [
            isSelected ? SvgPicture.asset('assets/common/checkboxChecked.svg') : SvgPicture.asset('assets/common/checkbox.svg'),
            Text(
              text,
              style: TextStyle(color: greyColor, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ┏━━━━━━━━━━━━┓
      // ┃   AppBar   ┃
      // ┗━━━━━━━━━━━━┛
      appBar: AppBar(
        title: Text("기본 정보 입력", style: TextStyle(fontSize: mq.width * .05, color: greyColor)),
        // AppBar - actions - 닫기 (로그아웃)
        actions: [
          SizedBox(
            width: mq.width * .13,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  overlayColor: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () async {
                  await APIs.auth.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                },
                child: SvgPicture.asset(
                  "$commonPath/icon/close_icon.svg",
                )),
          )
        ],
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
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
              // ┏━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 상단 여백  ┃
              // ┗━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                height: mq.height * .04,
              ),
              // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 이름 입력 TextField  ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                width: mq.width * .85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이름 - TEXT
                    Container(
                      padding: EdgeInsets.only(left: mq.width * .05),
                      child: Text("이름", style: TextStyle(color: greyColor, fontWeight: FontWeight.w800, fontSize: mq.width * .04)),
                    ),
                    // 이름 - TEXT FIELD
                    Card(
                      color: const Color.fromRGBO(230, 230, 230, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                      child: SizedBox(
                        width: mq.width,
                        height: mq.height * .06,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                inputFormatters: [_LengthLimitingTextInputFormatterFixed(10)],
                                focusNode: _focusNode,
                                controller: _textController,
                                style: TextStyle(fontSize: mq.width * .04, letterSpacing: -0.24),
                                decoration: InputDecoration(
                                  hintText: '이름 (최대 10자)',
                                  hintStyle: TextStyle(color: const Color.fromRGBO(188, 188, 188, 1), fontSize: mq.width * .04),
                                  border: InputBorder.none,
                                  focusColor: greyColor,
                                  contentPadding: EdgeInsets.symmetric(horizontal: mq.width * .045),
                                ),
                              ),
                            ),
                            // TEXT FIELD 초기화 버튼
                            _textController.text != ''
                                ? SizedBox(
                                    width: mq.width * .13,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          overlayColor: Colors.transparent,
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _textController.text = "";
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          "$commonPath/icon/close_icon.svg",
                                        )),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // ┏━━━━━━━━┓
              // ┃  여백  ┃
              // ┗━━━━━━━━┛
              SizedBox(
                height: mq.height * .03,
              ),
              // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 성별 선택 RADIO   ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                width: mq.width * .85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: mq.width * .05),
                      child: Text("성별", style: TextStyle(color: greyColor, fontWeight: FontWeight.w800, fontSize: mq.width * .04)),
                    ),
                    Container(
                      height: mq.height * .05,
                      margin: EdgeInsets.only(left: mq.width * .05, top: mq.height * .01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _buildCustomRadioButton('남성', 'M'),
                          SizedBox(width: mq.width * .03),
                          _buildCustomRadioButton('여성', 'G'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ┏━━━━━━━━┓
              // ┃  여백  ┃
              // ┗━━━━━━━━┛
              SizedBox(
                height: mq.height * .03,
              ),
              // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 생일 선택         ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                width: mq.width * .85,
                height: mq.height * .15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: mq.width * .05),
                      child: Text("생년월일", style: TextStyle(color: greyColor, fontWeight: FontWeight.w800, fontSize: mq.width * .04)),
                    ),
                    GestureDetector(
                      onTap: () => _showCupertinoDatePicker(context),
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: mq.width * .05, horizontal: mq.height * .04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _isDateSelected
                                  ? Text(
                                      CustomDateUtil.getOrgTime(
                                          context: context, date: _selectedDate.millisecondsSinceEpoch.toString(), returnType: "korYMD"),
                                      style: TextStyle(fontSize: mq.width * .04, color: greyColor),
                                    )
                                  : Text(
                                      '태어난 날짜를 선택해 주세요.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: greyColor,
                                        fontSize: mq.width * .04,
                                      ),
                                    ),
                              SvgPicture.asset('assets/common/arrowBottom.svg')
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      // ┃  BottomSheet - 시작하기 버튼   ┃
      // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      bottomSheet: SizedBox(
          width: mq.width,
          height: mq.height * 0.08,
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                // 이름, 성별, 생년 월일 입력 확인
                backgroundColor: _textController.text != '' && _selectedGender.isNotEmpty && _isDateSelected
                    ? const Color.fromRGBO(255, 135, 81, 1)
                    : const Color.fromRGBO(181, 181, 181, 1),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
              ),
              onPressed: _textController.text != '' && _selectedGender.isNotEmpty && _isDateSelected
                  ? _selectedDate.millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch
                      ? () {
                          _updateUserInfo();
                        }
                      : () {
                          CustomDialogs.showCustomToast(context, "생일을 확인 해 주세요!");
                        }
                  : () {},
              label: RichText(
                text: TextSpan(text: '시작하기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: mq.width * .07)),
              ))),
    );
  }
}

// ┏━━━━━━━━━━━━━━━━━━━━━┓
// ┃  글자수 오버 체크   ┃
// ┗━━━━━━━━━━━━━━━━━━━━━┛
class _LengthLimitingTextInputFormatterFixed extends TextInputFormatter {
  final int maxLength;

  _LengthLimitingTextInputFormatterFixed(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.characters.length > maxLength) {
      return oldValue;
    }
    return newValue;
  }
}
