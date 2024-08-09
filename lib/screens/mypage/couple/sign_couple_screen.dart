import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/apis/couple_apis.dart';
import 'package:flutter_lover_tale/apis/user_apis.dart';
import 'package:flutter_lover_tale/helper/custom_dialogs.dart';
import 'package:flutter_lover_tale/models/user_model.dart';
import 'package:flutter_lover_tale/screens/home_screen.dart';
import 'package:flutter_lover_tale/screens/mypage/couple/couple_request_screen.dart';

import '../../../apis/apis.dart';
import '../../../main.dart';
import '../../../models/couple_request_model.dart';
import '../../auth/login_screen.dart';

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

  // ┏━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   포커스 노드 제거   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Text("다음에하기 임시"),
          onPressed: () async {
            // 비동기 작업 2: Firebase 로그아웃
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
          },
        ),
        backgroundColor: const Color.fromRGBO(56, 56, 60, 1), // Sign Couple Screen backgroundColor
        // ┏━━━━━━━━━━┓
        // ┃  AppBar  ┃
        // ┗━━━━━━━━━━┛
        appBar: AppBar(
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const CoupleRequestScreen()));
                    },
                    icon: const Icon(Icons.mail)),
                StreamBuilder(
                    stream: CoupleAPIs.getMyCoupleRequest(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      final list = data?.map((e) => CoupleReq.fromJson(e.data())).toList() ?? [];
                      return Positioned(
                        left: 4,
                        top: 4,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: list.isNotEmpty ? Colors.red : null,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 10,
                            minHeight: 10,
                          ),
                        ),
                      );
                    }),
              ],
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
                  height: mq.height * .05,
                ),
                const Text(
                  "시작 전 커플 등록이  필요 해요.",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                SizedBox(
                  width: mq.width * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "내 코드",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      ElevatedButton(onPressed: () {}, child: const Text('공유하기'))
                    ],
                  ),
                ),
                Container(
                  width: mq.width ,
                  height: 50,
                  color: Colors.amberAccent,
                  child: Row(
                    children: [
                      Text(APIs.me.userCode),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.copy))
                    ],
                  ),
                ),
                const Text(
                  "코드 등록 하기",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: mq.height * .04),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 6,
                            style: const TextStyle(fontSize: 14, letterSpacing: -0.24),
                            decoration: InputDecoration(
                              hintText: '상대방 코드를 입력하세요',
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: mq.width * .06, top: 0, bottom: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          await CoupleAPIs.sendCoupleRequest(partner);
                          CustomDialogs.showSnackbar(context, "요청이 전송 되었습니다.");
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
