import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lover_tale/main.dart';
import 'package:flutter_lover_tale/widgets/story/story_write_date_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                             ┃
// ┃                               이야기 작성 화면                              ┃
// ┃                                                                             ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

class StoryWriteScreen extends StatefulWidget {
  const StoryWriteScreen({super.key});

  @override
  State<StoryWriteScreen> createState() => _StoryWriteScreenState();
}

class _StoryWriteScreenState extends State<StoryWriteScreen> {
  // ┏━━━━━━━━━━━━━━━┓
  // ┃   initState   ┃
  // ┗━━━━━━━━━━━━━━━┛
  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(_onTextChanged);
    _contentTextController.addListener(_onTextChanged);
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   포커스 노드 제거   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  void dispose() {
    _titleTextController.dispose();
    _contentTextController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // 포커스 노드
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  // 채팅창 TextField 컨트롤러
  final _titleTextController = TextEditingController(text: "");
  final _contentTextController = TextEditingController(text: "");

  // 텍스트 필드 입력시 스테이트 업데이트
  void _onTextChanged() {
    setState(() {});
  }

  // 선택된 이모지
  late String _selectedEmoji = 'love';

  // 이모지 리스트
  final List<String> _emojiList = ['love', 'smile', 'sad', 'angry', 'normal', 'surprise'];

  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<State>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  @override
  Widget build(BuildContext context) {
    // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
    // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    return Scaffold(
      // ┏━━━━━━━━━━━━┓
      // ┃   AppBar   ┃
      // ┗━━━━━━━━━━━━┛
      appBar: AppBar(
        title: Text(
          "다이어리",
          style: TextStyle(fontSize: mq.width * .05, color: Colors.white),
        ),
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: orangeColor,
      ),
      // ┏━━━━━━━━━━┓
      // ┃   Body   ┃
      // ┗━━━━━━━━━━┛
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _titleFocusNode.unfocus();
          _contentFocusNode.unfocus();
        },
        child: Column(
          children: [
            // ┏━━━━━━━━━━━━━━━━━━━━━━┓
            // ┃   Body - 상단 날짜   ┃
            // ┗━━━━━━━━━━━━━━━━━━━━━━┛
            Stack(
              children: [
                // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                // ┃   Body - 상단 날짜 - 기본 뒷배경   ┃
                // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                Positioned(
                    child: SizedBox(
                  width: mq.width,
                  height: mq.height * .15,
                )),
                // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                // ┃   Body - 상단 날짜 - 날짜 배경   ┃
                // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                Positioned(
                    child: Container(
                  width: mq.width,
                  height: mq.height * .14,
                  decoration: BoxDecoration(
                    color: orangeColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(250, 210, 192, 1.0),
                        spreadRadius: 2, // 그림자 퍼짐 정도
                        blurRadius: 5, // 그림자의 흐려짐 정도
                        offset: Offset(0, 2), // 그림자의 위치 (x축, y축 이동값)
                      )
                    ],
                  ),
                )),
                // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                // ┃   Body - 상단 날짜 - 날짜 카드   ┃
                // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                Positioned(
                    child: SizedBox(
                  width: mq.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const StoryWriteDateWidget(diffType: "subtract", hour: 48), // 2일전 카드
                      const StoryWriteDateWidget(diffType: "subtract", hour: 24), // 1일전 카드
                      // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                      // ┃   Body - 상단 날짜 - 날짜 카드 - 오늘   ┃
                      // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                      Container(
                        width: mq.width * .22,
                        height: mq.height * .15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: orangeColor,
                              spreadRadius: 1, // 그림자 퍼짐 정도
                              blurRadius: 5, // 그림자의 흐려짐 정도
                              offset: const Offset(0, 0), // 그림자의 위치 (x축, y축 이동값)
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 년. 월
                            Text("${DateTime.now().year.toString()}. ${DateTime.now().month}",
                                style:
                                    TextStyle(fontSize: mq.width * .035, height: mq.width * .007, color: orangeColor, fontWeight: FontWeight.w700)),
                            // 여백
                            Text("", style: TextStyle(fontSize: mq.width * .01)),
                            // 일
                            Text(DateTime.now().day.toString(),
                                style: TextStyle(fontSize: mq.width * .08, height: mq.width * .003, color: orangeColor, fontWeight: FontWeight.w800)),
                            // 요일
                            Text("수",
                                style: TextStyle(fontSize: mq.width * .05, height: mq.width * .002, color: orangeColor, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      const StoryWriteDateWidget(diffType: "add", hour: 24), // 1일후 카드
                      const StoryWriteDateWidget(diffType: "add", hour: 48), // 2일후 카드
                    ],
                  ),
                ))
              ],
            ),
            // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
            // ┃   Body - 중단 메인 컨텐츠   ┃
            // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
            Expanded(
                child: SingleChildScrollView(
                    child: SizedBox(
              width: mq.width,
              child: Column(
                children: [
                  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                  // ┃   Body - 중단 메인 컨텐츠 - 오늘의 감정 title   ┃
                  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                  Container(
                    margin: EdgeInsets.only(top: mq.height * .03, left: mq.width * .08),
                    height: mq.height * .03,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 아이콘
                        SvgPicture.asset("$commonPath/icon/emotion_icon.svg"),
                        // 타이틀 텍스트
                        Text(
                          " 오늘의 감정",
                          style: TextStyle(fontSize: mq.width * .04, color: greyColor, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                  // ┃   Body - 중단 메인 컨텐츠 - 오늘의 감정   ┃
                  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                  Container(
                    margin: EdgeInsets.only(top: mq.height * .02, left: mq.width * .08),
                    width: mq.width,
                    height: mq.width * .2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _emojiList.length,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedEmoji = _emojiList[index];
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              overlayColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Container(
                              width: mq.width * .2,
                              margin: EdgeInsets.only(right: mq.width * .02),
                              padding: EdgeInsets.all(mq.width * .02),
                              decoration: BoxDecoration(
                                  border: _selectedEmoji == _emojiList[index]
                                      ? Border.all(color: orangeColor, width: 3)
                                      : Border.all(color: const Color.fromRGBO(214, 214, 214, 1.0), width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(15))),
                              child: Image.asset(
                                "$commonPath/emoji/emoji_${_emojiList[index]}.png",
                                width: mq.width * .15,
                                height: mq.width * .15,
                              ),
                            ));
                      },
                    ),
                  ),
                  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                  // ┃   Body - 중단 메인 컨텐츠 - 제목 title   ┃
                  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                  Container(
                    margin: EdgeInsets.only(top: mq.height * .04, left: mq.width * .08),
                    height: mq.height * .03,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("$commonPath/icon/text_icon.svg"),
                        Text(
                          " 제목",
                          style: TextStyle(fontSize: mq.width * .04, color: greyColor, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
                  // ┃   Body - 중단 메인 컨텐츠 - 제목   ┃
                  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                  Card(
                    margin: EdgeInsets.only(top: mq.height * .02),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), side: BorderSide(color: lightGreyColor, width: 2)),
                    elevation: 0,
                    child: SizedBox(
                      width: mq.width * .84,
                      height: mq.height * .06,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              inputFormatters: [_LengthLimitingTextInputFormatterFixed(30)],
                              focusNode: _titleFocusNode,
                              controller: _titleTextController,
                              style: TextStyle(fontSize: mq.width * .04, letterSpacing: -0.24),
                              decoration: InputDecoration(
                                hintText: '제목 (최대 30글자)',
                                hintStyle: TextStyle(color: hintColor, fontSize: mq.width * .04),
                                border: InputBorder.none,
                                focusColor: greyColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: mq.width * .045),
                              ),
                            ),
                          ),
                          // TEXT FIELD 초기화 버튼
                          _titleTextController.text != ''
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
                                          _titleTextController.text = "";
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
                  ),
                  Container(
                    height: mq.height * .03,
                    margin: EdgeInsets.only(top: mq.height * .04, left: mq.width * .08),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("$commonPath/icon/picture_icon.svg"),
                        Text(
                          " 사진",
                          style: TextStyle(
                            fontSize: mq.width * .04,
                            color: greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: mq.width * .25,
                      margin: EdgeInsets.only(top: mq.height * .02, left: mq.width * .08),
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(mq.width * .25, mq.width * .25),
                                  backgroundColor: Color.fromRGBO(214, 214, 214, 1.0),
                                  padding: EdgeInsets.zero,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              child: SvgPicture.asset(
                                "$commonPath/icon/add_icon.svg",
                                width: mq.width * .07,
                              ))
                        ],
                      )),
                  Container(
                    height: mq.height * .03,
                    margin: EdgeInsets.only(top: mq.height * .04, left: mq.width * .08),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("$commonPath/icon/write_icon.svg"),
                        Text(
                          " 내용",
                          style: TextStyle(
                            fontSize: mq.width * .04,
                            color: greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: mq.height * .02),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), side: BorderSide(color: lightGreyColor, width: 2)),
                    elevation: 0,
                    child: SizedBox(
                      width: mq.width * .84,
                      height: mq.height * .18,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              inputFormatters: [_LengthLimitingTextInputFormatterFixed(200)],
                              minLines: 5,
                              maxLines: null,
                              focusNode: _contentFocusNode,
                              controller: _contentTextController,
                              style: TextStyle(fontSize: mq.width * .04, letterSpacing: -0.24),
                              decoration: InputDecoration(
                                hintText: '내용 (최대 200글자)',
                                hintStyle: TextStyle(color: hintColor, fontSize: mq.width * .04),
                                border: InputBorder.none,
                                focusColor: greyColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: mq.width * .045),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: mq.width * .83,
                    height: mq.height * .03,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${_contentTextController.text.length} / 200 ",
                          style: TextStyle(
                            fontSize: mq.width * .03,
                            color: greyColor,
                          ),
                        ),
                        SizedBox(
                            width: mq.width * .05,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  overlayColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                child: SvgPicture.asset('$commonPath/icon/add_circle_icon.svg'))),
                      ],
                    ),
                  ),
                  Container(
                    height: mq.height * .03,
                    margin: EdgeInsets.only(top: mq.height * .04, left: mq.width * .08),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("$commonPath/icon/location_icon.svg"),
                        Text(
                          " 위치",
                          style: TextStyle(
                            fontSize: mq.width * .04,
                            color: greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  // 하단 여백
                  SizedBox(height: mq.height * .15)
                ],
              ),
            )))
          ],
        ),
      ),
      bottomSheet: SizedBox(
          width: mq.width,
          height: mq.height * .08,
          child: Column(
            children: [
              SizedBox(
                width: mq.width,
                height: mq.height * .08,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      // 이름, 성별, 생년 월일 입력 확인
                      // backgroundColor: _textController.text != '' && _selectedGender.isNotEmpty && _isDateSelected
                      //     ? orangeColor
                      //     : const Color.fromRGBO(181, 181, 181, 1),
                      backgroundColor: orangeColor,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                    ),
                    onPressed:
                        // _textController.text != '' && _selectedGender.isNotEmpty && _isDateSelected
                        //     ? _selectedDate.millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch
                        //     ? () {
                        //   _updateUserInfo();
                        // }
                        //     : () {
                        //   CustomDialogs.showCustomToast(context, "생일을 확인 해 주세요!");
                        // }
                        //     :
                        () {
                      print(_selectedEmoji);
                      print(_titleTextController.text);
                      print(_contentTextController.text);
                    },
                    label: RichText(
                      text: TextSpan(text: '등록', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: mq.width * .07)),
                    )),
              ),
            ],
          )),
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
