// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                  ┃
// ┃                                    UserModel                                     ┃
// ┃                                                                                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class ModuUser {
  ModuUser({
    required this.id,                     // 고유 아이디
    required this.name,                   // 이름
    required this.gender,                 // 성별
    required this.birthDay,               // 생일
    required this.image,                  // 프로필 이미지
    required this.createdAt,              // 계정 생성일
    required this.email,                  // 이메일
    required this.pushToken,              // 푸시 알림용 토큰
    required this.coupleId,              // 파트너 아이디
    required this.userCode,
  });

  late String id;
  late String name;
  late String gender;
  late String birthDay;
  late String image;
  late String createdAt;
  late String email;
  late String pushToken;
  late String coupleId;
  late String userCode;

  ModuUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    gender = json['gender'] ?? '';
    birthDay = json['birth_day'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    coupleId = json['couple_id'] ?? '';
    userCode = json['user_code'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['gender'] = gender;
    data['birth_day'] = birthDay;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['couple_id'] = coupleId;
    data['user_code'] = userCode;
    return data;
  }
}
