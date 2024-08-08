import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lover_tale/models/couple_request_model.dart';
import 'package:flutter_lover_tale/models/user_model.dart';
import 'package:flutter_lover_tale/widgets/couple_req_card.dart';

import '../../apis/apis.dart';
import '../../apis/user_apis.dart';
import '../../main.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                             커플 요청 확인 화면                            ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class CoupleRequestScreen extends StatefulWidget {
  const CoupleRequestScreen({super.key});

  @override
  State<CoupleRequestScreen> createState() => _CoupleRequestScreenState();
}

class _CoupleRequestScreenState extends State<CoupleRequestScreen> {
  // <내가 id가 포함된 채팅방 리스트> 초기화
  late List<CoupleReq> _reqList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 56, 60, 1), // Couple Request Screen backgroundColor
      appBar: AppBar(title: Text("내게 온 요청")),
      body: SizedBox(
        width: mq.width,
        height: mq.height,
        child: StreamBuilder(
          stream: UserAPIs.getMyCoupleRequest(),
          builder: (context, coupleReqSnapshot) {
            switch (coupleReqSnapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = coupleReqSnapshot.data;
                _reqList = data?.map((e) => CoupleReq.fromJson(e.data())).toList() ?? [];
                return ListView.builder(
                  itemCount: _reqList.length,
                  itemBuilder: (context, index) {
                    ModuUser partner = ModuUser(
                        id: '',
                        name: '',
                        gender: '',
                        birthDay: '',
                        image: '',
                        createdAt: '',
                        email: '',
                        pushToken: '',
                        partnerId: '');
                    // chatRoomList 의 member 리스트의 첫번째 ID가 나면 두번째 ID를 조회 parameter 저장
                    if (_reqList[index].member[0] == APIs.me.id) {
                      partner.id = _reqList[index].member[1];
                    }
                    // chatRoomList 의 member 리스트의 두번째 ID가 나면 첫번째 ID를 조회 parameter 저장
                    else {
                      partner.id = _reqList[index].member[0];
                    }
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: UserAPIs.streamUserInfo(partner),
                        builder: (context, userSnapshot) {
                          switch (userSnapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = userSnapshot.data?.docs;
                              List<ModuUser> users =
                                  data?.map((e) => ModuUser.fromJson(e.data())).toList() ?? [];
                              if (users.isNotEmpty) {
                                return CoupleReqCard(user : users[0]);
                              } else {
                                return const Center(
                                    child: Text(
                                  "유저가 존재 하지 않습니다.",
                                  style: TextStyle(color: Colors.white),
                                ));
                              }
                          }
                        });
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
