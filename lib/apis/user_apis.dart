import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lover_tale/models/user_model.dart';
import 'package:uuid/uuid.dart';

import 'apis.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                                    ┃
// ┃                                            User API                                                ┃
// ┃                                                                                                    ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class UserAPIs {
  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 현재 로그인 된 유저 정보가 DB에 있는지 확인                     ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static Future<bool> userExists() async {
    return (await APIs.fireStore.collection('CL_USER').doc(APIs.user.uid).get()).exists;
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   현재 접속 유저 정보 - DB에 없을시 새로운 유저 생성                ┃
  // ┃   HomeScreen 에서 로그인 정보로 DB 조회 후 me <- user               ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  1. 유저 컬렉션 에서 내 아이디로 된 유저 정보 조회
  *  2. 있으면 APIs.me 에 접속 정보 넣기
  *  3. 없으면 createUser() 로 db 에 내 정보 추가 후 getSelfInfo 재 호출
  * */
  static Future<void> getSelfInfo() async {
    return APIs.fireStore.collection('CL_USER').doc(APIs.user.uid).get().then((user) async {
      if (user.exists) {
        APIs.me = ModuUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● DB에 새로운 유저 생성                                           ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  1. uuid 생성 하여 클라이언트에 노출 가능한 uuid 값 생성
  *  2. ModuUser 객체 생성 후 db에 넣을 값들 추가
  *  3. 유저 컬렉션에 ModuUser 에 넣은 데이터로 doc 생성
  * */
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // 고유 uuid 생성
    var uuid = const Uuid();
    String userCode = uuid.v4();
    final moduUser = ModuUser(
      id: APIs.user.uid,
      name: APIs.user.displayName.toString(),
      image: APIs.user.photoURL.toString(),
      createdAt: time,
      pushToken: '',
      gender: '',
      birthDay: '',
      email: APIs.user.email.toString(),
      coupleId: '',
      userCode: userCode,
    );
    return await APIs.fireStore.collection('CL_USER').doc(APIs.user.uid).set(moduUser.toJson());
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 로그인 기록 저장                                                ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  1. 로그인 시간과 플랫폼 기록을 위한 함수 (로그인 할때만 기록)
  *  2. 'CL_USER' 컬렉션에 내 아이디 doc 에 LOGIN_HIST 컬렉션에 doc 생성
  * */
  static Future<void> logLoginHist() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else if (Platform.isAndroid) {
      platform = 'Android';
    } else {
      platform = '';
    }
    APIs.fireStore
        .collection('CL_USER')
        .doc(APIs.user.uid)
        .collection('LOGIN_HIST')
        .doc(time)
        .set({'login_dtm': time, 'platform': platform});
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● 기본 정보 입력 update                                           ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO :
  *  'CL_USER' 컬렉션에 info_insert_screen 화면 에서 입력한 값들 update
  * */
  static Future<void> updateUserDefaultInfo(ModuUser user) async {
    APIs.fireStore
        .collection('CL_USER')
        .doc(APIs.user.uid)
        .update({'name' : user.name,'gender': user.gender, 'birth_day': user.birthDay});
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● "user_id" 로 특정 유저 정보 조회                                ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  /*
  * TODO : Future Builder 로 조회시
  * */
  static Future<QuerySnapshot<Map<String, dynamic>>> getUserInfo(ModuUser user) async {
    return await APIs.fireStore.collection('CL_USER').where('id', isEqualTo: user.id).get();
  }
  /*
  * TODO : Stream Builder 로 조회시
  * */
  static Stream<QuerySnapshot<Map<String, dynamic>>> streamUserInfo(ModuUser user) {
    return APIs.fireStore.collection('CL_USER').where('id', isEqualTo: user.id).snapshots();
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃   ● "user_code" 로 특정 유저 정보 조회                              ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  static Future<QuerySnapshot<Map<String, dynamic>>> getUserInfoFromUserCode(ModuUser user) async {
    return await APIs.fireStore.collection('CL_USER').where('user_code', isEqualTo: user.userCode).get();
  }
}
