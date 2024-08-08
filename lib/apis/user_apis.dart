import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lover_tale/models/couple_request_model.dart';
import 'package:flutter_lover_tale/models/user_model.dart';

import 'apis.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                                    ┃
// ┃                                            User API                                                ┃
// ┃                                                                                                    ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class UserAPIs {
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 기본 정보 입력 update                                           ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static Future<void> updateUserDefaultInfo(ModuUser user) async {
    APIs.fireStore
        .collection('CL_USER')
        .doc(APIs.user.uid)
        .update({'name' : user.name,'gender': user.gender, 'birth_day': user.birthDay});
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 특정 유저 정보 조회                                             ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static Future<QuerySnapshot<Map<String, dynamic>>> getUserInfo(ModuUser user) async {
    return await APIs.fireStore.collection('CL_USER').where('id', isEqualTo: user.id).get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> streamUserInfo(ModuUser user) {
    return APIs.fireStore.collection('CL_USER').where('id', isEqualTo: user.id).snapshots();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 커플 등록 되어 있는지 확인                                      ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static Future<bool> checkUserCouple(ModuUser partner) async {
    var userInfoSnapshot = await getUserInfo(partner);
    if (userInfoSnapshot.docs.isNotEmpty) {
      ModuUser userData = ModuUser.fromJson(userInfoSnapshot.docs.first.data());
      if (userData.partnerId.isEmpty) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 커플 요청 아이디 생성 하기                                       ┃
  // ┃     - 내 아이디와 상대방 아이디로 만들어진 커플 요청 아이디 생성     ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static String getCoupleReqId(String id) =>
      APIs.user.uid.hashCode <= id.hashCode ? '${APIs.user.uid}_$id' : '${id}_${APIs.user.uid}';

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 커플 요청                                                        ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static Future<void> sendCoupleRequest(ModuUser partner) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    List<String> member = [];
    // 멤버 리스트 들어 가는 순서
    if (APIs.user.uid.hashCode <= partner.id.hashCode) {
      member.add(APIs.user.uid);
      member.add(partner.id);
    } else {
      member.add(partner.id);
      member.add(APIs.user.uid);
    }
    // 요청 아이디 GEN
    String coupleReqId = 'DC_${getCoupleReqId(partner.id)}';

    CoupleReq coupleReq =
        CoupleReq(id: coupleReqId, fromId: APIs.user.uid, creDtm: time, member: member);
    try {
      final ref = APIs.fireStore.collection('CL_COUPLE_REQ');
      await ref.doc(coupleReqId).set(coupleReq.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 내게 온 요청 모두 조회                                           ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
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
