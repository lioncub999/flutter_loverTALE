import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lover_tale/apis/user_apis.dart';
import 'package:flutter_lover_tale/models/couple_request_model.dart';
import 'package:flutter_lover_tale/models/user_model.dart';
import 'package:uuid/uuid.dart';

import 'apis.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                                    ┃
// ┃                                           Couple API                                               ┃
// ┃                                                                                                    ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class CoupleAPIs {
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 커플 요청 아이디 생성 하기                                       ┃
  // ┃     - 내 아이디와 상대방 아이디로 만들어진 커플 요청 아이디 생성     ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  1. 상대방 유저의 uid 값으로 내 아이디와 hashCode 값 비교 해서 값 작거나 같은 id가 앞으로 오도록
  *  2. id Ex) (작은아이디)_(큰아이디)
  * */
  static String getCoupleReqId(String id) =>
      APIs.user.uid.hashCode <= id.hashCode ? '${APIs.user.uid}_$id' : '${id}_${APIs.user.uid}';

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● "user_code" 로 커플 등록 되어 있는지 확인                       ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  1. 클라이언트 에서 받은 partner 의 user_code 값으로 유저 정보 조회.
  *  2. 해당 값으로 유저가 조회 된다면 조회된 리스트 중 가장 첫번째 값을 ModuUser 객체에 저장 (어차피 고유값 이라 하나만 조회 될거임)
  *  3. 조회된 유저 데이터 에 coupleId 가 빈값 이면 커플 등록이 안돼 있는 것 이므로 return true
  *  4. 조회된 유저 데이터가 없거나 조회가 됐더라도 coupleId 값이 빈값이 아니면 return false
  * */
  static Future<bool> checkUserCouple(ModuUser partner) async {
    var userInfoSnapshot = await UserAPIs.getUserInfoFromUserCode(partner);
    if (userInfoSnapshot.docs.isNotEmpty) {
      ModuUser userData = ModuUser.fromJson(userInfoSnapshot.docs.first.data());
      if (userData.coupleId.isEmpty) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 커플 요청 날리기                                                 ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  *  TODO :
  *   1. 파트너 "user_code" 로 유저 정보 가져옴.
  *   2. 가져온 정보로 couple_req 에 들어갈 member 리스트 값 넣어줌
  *   3. 내 아이디, 파트너 아이디로 조함한 getCoupleReqId로 요청 아이디 생성
  *   4. 'CL_COUPLE_REQ' 컬렉션에 데이터 넣기
  * */
  static Future<void> sendCoupleRequest(ModuUser partner) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    var userInfoSnapshot = await UserAPIs.getUserInfoFromUserCode(partner);

    if (userInfoSnapshot.docs.isNotEmpty) {
      ModuUser userData = ModuUser.fromJson(userInfoSnapshot.docs.first.data());

      List<String> member = [];
      // 멤버 리스트 들어 가는 순서 조정
      if (APIs.user.uid.hashCode <= userData.id.hashCode) {
        member.add(APIs.user.uid);
        member.add(userData.id);
      } else {
        member.add(userData.id);
        member.add(APIs.user.uid);
      }
      // req Id GEN
      String coupleReqId = 'DC_${getCoupleReqId(userData.id)}';

      CoupleReq coupleReq =
          CoupleReq(id: coupleReqId, fromId: APIs.user.uid, creDtm: time, member: member);
      try {
        final ref = APIs.fireStore.collection('CL_COUPLE_REQ');
        await ref.doc(coupleReqId).set(coupleReq.toJson());
      } catch (e) {
        rethrow;
      }
    }
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 커플 요청 수락                                                   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  1. REQ 의 member 리스트에 있는 두명의 유저 컬렉션에 couple_id 값을 요청 아이디로 업데이트 <- 커플 아이디와 값 같음
  *  2. 'CL_COUPLE' 컬렉션에 커플 아이디로 문서 생성 후 cre_dtm, love_start_day 세팅
  * */
  static Future<void> confirmCouple(CoupleReq req) async {
    await APIs.fireStore.collection('CL_USER').doc(req.member[0]).update({'couple_id': req.id});
    await APIs.fireStore.collection('CL_USER').doc(req.member[1]).update({'couple_id': req.id});
    await APIs.fireStore.collection('CL_COUPLE').doc(req.id).set({'cre_dtm' : DateTime.now().millisecondsSinceEpoch});
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 내게 온 요청 모두 조회                                           ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  1. 'CL_COUPLE_REQ' 컬렉션 에서 member list 에 내 id 들어간 doc 모두 가져오기.
  *  2. 가져온 값 중에서 from_id (요청 보낸 사람) 가 내가 아닌 것들만 다시 가져오기.
  * */
  static Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMyCoupleRequest() {
    return APIs.fireStore
        .collection('CL_COUPLE_REQ')
        .where('member', arrayContains: APIs.user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.where((doc) => doc.data()['from_id'] != APIs.user.uid).toList();
    });
  }
}
