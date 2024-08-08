import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // 성별 선택
  int _selectedGender = 0;

  // 생일 선택
  late bool _isDateSelected = false;
  DateTime _selectedDate = DateTime.now();

  // 포커스 노드
  final FocusNode _focusNode = FocusNode();

  // 채팅창 TextField 컨트롤러
  final _textController = TextEditingController(text: APIs.me.name);

  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  // 텍스트 필드 입력시 스테이트 업데이트
  void _onTextChanged() {
    setState(() {});
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

  // ┏━━━━━━━━━━━━━━━━━━━━┓
  // ┃   라디오 버튼 UI   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━┛
  Widget _buildCustomRadioButton(int value, String text, String gender) {
    bool isSelected = _selectedGender == value;
    return SizedBox(
      width: mq.width * .3,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedGender = value;
          });
        },
        child: Row(
          children: [
            isSelected
                ? SvgPicture.asset('assets/common/checkboxChecked.svg')
                : SvgPicture.asset('assets/common/checkbox.svg'),
            Text(
              text,
              style: const TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃  HomeScreen 이동 페이지 Blur ROUTE   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  Route _moveHomeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0 * animation.value,
                sigmaY: 10.0 * animation.value,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.1 * animation.value),
              ),
            ),
            FadeTransition(
              opacity: animation,
              child: child,
            ),
          ],
        );
      },
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
      appBar: AppBar(
        title: const Text("기본 정보 입력"),
        actions: [
          IconButton(onPressed: () async {
            // 비동기 작업 2: Firebase 로그아웃
            await APIs.auth.signOut();
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
          }, icon: const Icon(Icons.clear))
        ],
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1), // LoginScreen backgroundColor
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
              // 위쪽 여백
              SizedBox(
                width: mq.width,
                height: mq.height * .04,
              ),
              // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 이름 입력 TextField ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                width: mq.width * .85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이름 - TEXT
                    Container(
                      padding: EdgeInsets.only(left: mq.width * .05),
                      child: const Text("이름",
                          style: TextStyle(
                              color: Color.fromRGBO(109, 109, 109, 1),
                              fontWeight: FontWeight.w800,
                              fontSize: 16)),
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
                        height: mq.height * .05,
                        child: Stack(
                          children: [
                            TextField(

                              inputFormatters: [_LengthLimitingTextInputFormatterFixed(20)],
                              focusNode: _focusNode,
                              controller: _textController,
                              style: const TextStyle(fontSize: 16, letterSpacing: -0.24),
                              decoration: InputDecoration(
                                hintText: '이름 (최대 20자)',
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(188, 188, 188, 1), fontSize: 16),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: mq.width * .04,
                                    right: mq.width * .1,
                                    top: mq.height * .01,
                                    bottom: mq.height * .01),
                              ),
                            ),
                            // TEXT FIELD 초기화 버튼
                            _textController.text != ''
                                ? Positioned(
                                    top: -mq.height * .002,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Color.fromRGBO(188, 188, 188, 1),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _textController.clear();
                                        setState(() {});
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // 여백
              SizedBox(
                width: mq.width,
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
                      padding: EdgeInsets.only(left: mq.width * .03),
                      child: const Text("성별",
                          style: TextStyle(
                              color: Color.fromRGBO(109, 109, 109, 1),
                              fontWeight: FontWeight.w800,
                              fontSize: 16)),
                    ),
                    Container(
                      height: mq.height * .05,
                      margin: EdgeInsets.only(left: mq.width * .04, top: mq.height * .005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _buildCustomRadioButton(0, '남성', 'M'),
                          const SizedBox(width: 10),
                          _buildCustomRadioButton(1, '여성', 'G'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 여백
              SizedBox(
                width: mq.width,
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
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: mq.width * .03),
                      child: const Text("생년월일",
                          style: TextStyle(
                              color: Color.fromRGBO(109, 109, 109, 1),
                              fontWeight: FontWeight.w800,
                              fontSize: 16)),
                    ),
                    GestureDetector(
                      onTap: () => _showCupertinoDatePicker(context),
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _isDateSelected
                                  ? Text(
                                      '${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일',
                                      style: const TextStyle(
                                          fontSize: 16.0, color: Color.fromRGBO(109, 109, 109, 1)),
                                    )
                                  : const Text(
                                      '내 생일을 선택 해주세요.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(109, 109, 109, 1),
                                        fontSize: 16.0,
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
                backgroundColor: _textController.text != '' && _isDateSelected
                    ? const Color.fromRGBO(255, 135, 81, 1)
                    : const Color.fromRGBO(181, 181, 181, 1), // Btn-BackgroundColor
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))), // Btn-Shape
              ),
              onPressed: _textController.text != '' && _isDateSelected
                  ? () async {
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
                        partnerId: '',
                      );
                      try {
                        await UserAPIs.updateUserDefaultInfo(user);
                      } catch (e) {
                        rethrow;
                      }
                      Navigator.pushReplacement(context, _moveHomeRoute());
                    }
                  : () {},
              // 로그인 버튼
              label: RichText(
                text:
                    const TextSpan(style: TextStyle(color: Colors.black, fontSize: 16), children: [
                  TextSpan(
                      text: '시작하기',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25)),
                ]),
              ))),
    );
  }
}

// 글자수 오버 방지
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
