import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lover_tale/apis/couple_apis.dart';
import 'package:flutter_lover_tale/helper/custom_date_util.dart';
import 'package:flutter_lover_tale/helper/custom_dialogs.dart';
import 'package:flutter_lover_tale/models/user_model.dart';
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

class _SignCoupleScreenState extends State<SignCoupleScreen> {
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
  // 포커스 노드
  final FocusNode _focusNode = FocusNode();

  // 채팅창 TextField 컨트롤러
  final _textController = TextEditingController();

  // 텍스트 필드 입력시 스테이트 업데이트
  void _onTextChanged() {
    setState(() {});
  }

  // 등록 클릭 시 로딩 관리
  bool _isSubmitLoading = false;

  // 만난 날 선택 관리
  late bool _isDateSelected = false;
  DateTime _selectedDate = DateTime.now();
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

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
    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    return Scaffold(
        backgroundColor: Colors.white,
        // ┏━━━━━━━━━━┓
        // ┃  AppBar  ┃
        // ┗━━━━━━━━━━┛
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            // 내 코드 복사 버튼
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                elevation: WidgetStateProperty.all(0),
              ),
              onPressed: () async {
                Clipboard.setData(ClipboardData(text: APIs.me.userCode));
                CustomDialogs.showCustomToast(context, '코드가 복사 되었습니다.');
              },
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
        body: Container(
          color: Colors.white,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _focusNode.unfocus();
            },
            child: SizedBox(
              width: mq.width,
              height: mq.height,
              child: Column(
                children: [
                  // ┏━━━━━━━━━━━━━━━━━━━━━┓
                  // ┃  상단 문구, 캐릭터  ┃
                  // ┗━━━━━━━━━━━━━━━━━━━━━┛
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 좌측 여백
                        SizedBox(
                          width: mq.width * .05,
                        ),
                        // 좌측 문구 - "시작 전 커플 등록이 필요해요!"
                        SizedBox(
                          width: mq.width * .55,
                          child: Image.asset("$commonPath/text/couple_sign_text.png"),
                        ),
                        // 우측 캐릭터
                        SizedBox(
                          width: mq.width * .4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset("$commonPath/character/girl_right.png"),
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
                  // ┏━━━━━━━━━━━┓
                  // ┃  내 코드  ┃
                  // ┗━━━━━━━━━━━┛
                  // 내 코드 - title
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
                  // 내 코드 - 코드
                  SizedBox(
                    width: mq.width * .8,
                    height: mq.height * .05,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(246, 246, 246, 1),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: mq.width * .06),
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
                  ),
                  // ┏━━━━━━━━┓
                  // ┃  여백  ┃
                  // ┗━━━━━━━━┛
                  SizedBox(
                    height: mq.height * .05,
                  ),
                  // ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
                  // ┃  상대방 코드 등록하기  ┃
                  // ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
                  // 상대방 코드 등록하기 - title
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
                  // 상대방 코드 등록하기 - TextField
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
                                contentPadding: EdgeInsets.only(left: mq.width * .06),
                              ),
                            ),
                          ),
                          _textController.text == ''
                              ? Container()
                              : SizedBox(
                                  width: mq.width * .11,
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
                        ],
                      ),
                    ),
                  ),
                  // ┏━━━━━━━━┓
                  // ┃  여백  ┃
                  // ┗━━━━━━━━┛
                  SizedBox(
                    height: mq.height * .05,
                  ),
                  // ┏━━━━━━━━━━━━━━━━━━┓
                  // ┃  우리가 만난 날  ┃
                  // ┗━━━━━━━━━━━━━━━━━━┛
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 우리가 만난 날 - title
                      SizedBox(
                        width: mq.width * .45,
                        child: Text(
                          "우리가 만난 날",
                          style: TextStyle(color: greyColor, fontSize: mq.width * .06, fontWeight: FontWeight.w700),
                        ),
                      ),
                      // 우리가 만난 날 - 날짜 선택
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
                                  ),
                                  SizedBox(
                                    width: mq.width * .25,
                                    child: _isDateSelected
                                        ? Center(
                                            child: Text(
                                              CustomDateUtil.getOrgTime(context: context, date: _selectedDate.millisecondsSinceEpoch.toString(), returnType: "onlyMiddleBar"),
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
                  // ┏━━━━━━━━┓
                  // ┃  여백  ┃
                  // ┗━━━━━━━━┛
                  SizedBox(
                    height: mq.height * .13,
                  ),
                  // ┏━━━━━━━━━━━━━┓
                  // ┃  등록 버튼  ┃
                  // ┗━━━━━━━━━━━━━┛
                  _textController.text != '' && _isDateSelected
                      ? _isSubmitLoading
                          ? SizedBox(
                              width: mq.width * .4,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(250, 210, 192, 1.0),
                                  spreadRadius: 3, // 그림자 퍼짐 정도
                                  blurRadius: 10, // 그림자의 흐려짐 정도
                                  offset: Offset(0, 4), // 그림자의 위치 (x축, y축 이동값)
                                )
                              ]),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isSubmitLoading = true; // 로딩 종료
                                  });
                                  // 입력 값이 비어 있는지 먼저 확인하고, 비동기 작업 전에 스낵바 띄우기
                                  if (_textController.text == "") {
                                    CustomDialogs.showCustomToast(context, "코드를 확인 해주세요");
                                    setState(() {
                                      _isSubmitLoading = false; // 로딩 종료
                                    });
                                    return;
                                  }

                                  // 나 자신에게 보낼 경우에 대한 처리
                                  if (_textController.text == APIs.me.userCode) {
                                    CustomDialogs.showCustomToast(context, "나에게는 보낼 수 없어요~");
                                    setState(() {
                                      _isSubmitLoading = false; // 로딩 종료
                                    });
                                    return;
                                  }

                                  // 만난 날이 오늘 이후로 설정된 경우 처리
                                  if (_selectedDate.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch) {
                                    CustomDialogs.showCustomToast(context, "만난 날을 확인 해 주세요!");
                                    setState(() {
                                      _isSubmitLoading = false; // 로딩 종료
                                    });
                                    return;
                                  }

                                  // 비동기 작업 수행
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
                                    adNotShow: false,
                                  );

                                  // 결과에 따라 스낵바 표시 또는 화면 전환
                                  if (await CoupleAPIs.checkUserCouple(partner)) {
                                    await CoupleAPIs.sendCoupleRequest(partner, _selectedDate); // 요청 보내기 전 대기
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => CoupleRequestSuccessScreen(partner: partner)));
                                  } else {
                                    CustomDialogs.showCustomToast(context, "코드를 확인 해주세요");
                                  }
                                  setState(() {
                                    _isSubmitLoading = false; // 로딩 종료
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(mq.width * .35, mq.height * .08),
                                    backgroundColor: const Color.fromRGBO(255, 135, 81, 1.0),
                                    padding: EdgeInsets.zero,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("등록", style: TextStyle(color: baseWhite, fontSize: mq.width * .05, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            )
                      : Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(188, 188, 188, 1.0),
                              spreadRadius: 1, // 그림자 퍼짐 정도
                              blurRadius: 10, // 그림자의 흐려짐 정도
                              offset: Offset(0, 0), // 그림자의 위치 (x축, y축 이동값)
                            )
                          ]),
                          child: ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(mq.width * .35, mq.height * .08),
                                backgroundColor: Color.fromRGBO(188, 188, 188, 1.0),
                                padding: EdgeInsets.zero,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("등록", style: TextStyle(color: baseWhite, fontSize: mq.width * .05, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
